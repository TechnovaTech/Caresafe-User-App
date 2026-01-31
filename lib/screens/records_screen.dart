import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final List<_Record> _records = [
    const _Record(title: 'Blood Test Report', subtitle: 'Jan 15, 2026 • Dr. Priya Sharma'),
    const _Record(title: 'Prescription - Fever', subtitle: 'Jan 10, 2026 • Dr. Kevin Chen'),
    const _Record(title: 'X-Ray Report', subtitle: 'Jan 5, 2026 • Dr. Emily Watson'),
  ];

  Future<void> _pickAndUpload() async {
    final res = await FilePicker.platform.pickFiles(withData: true, allowMultiple: false);
    if (res != null && res.files.isNotEmpty) {
      final f = res.files.single;
      final now = DateTime.now();
      final date = '${_month(now.month)} ${now.day}, ${now.year}';
      final title = f.name;
      setState(() {
        _records.insert(0, _Record(title: title, subtitle: '$date • Uploaded')); // add to recent
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Document uploaded')));
      }
    }
  }

  String _month(int m) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[(m - 1).clamp(0, 11)];
  }

  void _download(String title) {
    if (kIsWeb) {
      final bytes = Uint8List.fromList('Dummy file for $title'.codeUnits);
      final blob = html.Blob([bytes], 'application/octet-stream');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)..download = title;
      anchor.click();
      html.Url.revokeObjectUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloaded')));
    }
  }

  void _delete(String title) {
    setState(() {
      _records.removeWhere((r) => r.title == title);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Record deleted')));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 380;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            const _StatusBar(),
            const SizedBox(height: 8),
            const Text(
              'Medical Records',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            const Text(
              'Manage your health documents',
              style: TextStyle(fontSize: 14, color: Color(0xFF667085)),
            ),
            const SizedBox(height: 16),

            // Category cards
            const _CategoryCard(
              icon: Icons.description_outlined,
              iconBg: Color(0xFF0A63E0),
              title: 'Prescriptions',
              subtitle: '12 files',
            ),
            const SizedBox(height: 12),
            const _CategoryCard(
              icon: Icons.biotech_outlined,
              iconBg: Color(0xFF16A34A),
              title: 'Lab Reports',
              subtitle: '8 files',
            ),
            const SizedBox(height: 12),
            const _CategoryCard(
              icon: Icons.folder_open,
              iconBg: Color(0xFFFFA000),
              title: 'Medical Documents',
              subtitle: '5 files',
            ),

            const SizedBox(height: 16),

            // Upload dashed tile
            _UploadTile(onUpload: _pickAndUpload),

            const SizedBox(height: 18),
            const Text(
              'Recent Records',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 10),

            ..._records.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _RecordItem(
                    title: r.title,
                    subtitle: r.subtitle,
                    isCompact: isCompact,
                    onDownload: () => _download(r.title),
                    onDelete: () => _delete(r.title),
                  ),
                )),

            const SizedBox(height: 90),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _SOSFab(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, '/consult');
          } else if (i == 2) {
            Navigator.pushReplacementNamed(context, '/sos');
          } else if (i == 3) {
            // already on Records
          } else if (i == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coming soon')),
            );
          }
        },
      ),
    );
  }
}

class _Record {
  final String title;
  final String subtitle;
  const _Record({required this.title, required this.subtitle});
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 24);
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  const _CategoryCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF667085))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF98A2B3)),
        ],
      ),
    );
  }
}

class _UploadTile extends StatelessWidget {
  final VoidCallback onUpload;
  const _UploadTile({required this.onUpload});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onUpload,
      child: CustomPaint(
        painter: _DashedBorderPainter(color: const Color(0xFF0A63E0), radius: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
          ),
          child: Row(
            children: const [
              _UploadIcon(),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload New Document', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                    SizedBox(height: 2),
                    Text('PDF, JPG, PNG up to 10MB', style: TextStyle(fontSize: 12, color: Color(0xFF667085))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadIcon extends StatelessWidget {
  const _UploadIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFE7F0FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.cloud_upload_outlined, color: Color(0xFF0A63E0)),
    );
  }
}

class _RecordItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompact;
  final VoidCallback onDownload;
  final VoidCallback onDelete;
  const _RecordItem({
    required this.title,
    required this.subtitle,
    required this.isCompact,
    required this.onDownload,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    final iconSize = isCompact ? 20.0 : 22.0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: isCompact ? 36 : 40,
            height: isCompact ? 36 : 40,
            decoration: BoxDecoration(color: const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.note_outlined, color: Color(0xFF667085)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: isCompact ? 36 : 40,
                height: isCompact ? 36 : 40,
                decoration: BoxDecoration(color: const Color(0xFFE7F0FF), borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  iconSize: iconSize,
                  onPressed: onDownload,
                  icon: const Icon(Icons.download_outlined, color: Color(0xFF0A63E0)),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: isCompact ? 36 : 40,
                height: isCompact ? 36 : 40,
                decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                  iconSize: iconSize,
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEB1C24)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  _DashedBorderPainter({
    required this.color,
    this.radius = 16,
    this.strokeWidth = 1.5,
    this.dashWidth = 6,
    this.dashSpace = 4,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    void drawDashedLine(Offset p1, Offset p2) {
      final total = (p2 - p1).distance;
      final direction = (p2 - p1) / total;
      double start = 0;
      while (start < total) {
        final end = start + dashWidth;
        final a = p1 + direction * start;
        final b = p1 + direction * (end > total ? total : end);
        canvas.drawLine(a, b, paint);
        start = end + dashSpace;
      }
    }

    final w = size.width;
    final h = size.height;
    // Top
    drawDashedLine(Offset(radius, 0), Offset(w - radius, 0));
    // Right
    drawDashedLine(Offset(w, radius), Offset(w, h - radius));
    // Bottom
    drawDashedLine(Offset(w - radius, h), Offset(radius, h));
    // Left
    drawDashedLine(Offset(0, h - radius), Offset(0, radius));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SOSFab extends StatelessWidget {
  const _SOSFab();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        heroTag: 'records-sos',
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/sos');
        },
        backgroundColor: const Color(0xFFEB1C24),
        elevation: 4,
        shape: const CircleBorder(),
        child: const Text(
          'SOS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
        ),
      ),
    );
  }
}