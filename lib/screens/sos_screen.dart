import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 380;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Column(
        children: [
          // Status bar space for date/time
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
            const _StatusBar(),
            const SizedBox(height: 8),

            // Header
            Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBEE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFEB1C24), size: 36),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Help is On The Way',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Emergency services have been alerted',
                  style: TextStyle(fontSize: 14, color: Color(0xFF667085)),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.access_time, size: 16, color: Color(0xFF667085)),
                    SizedBox(width: 6),
                    Text('00:19', style: TextStyle(fontSize: 13, color: Color(0xFF667085))),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Live Location
            const _SectionHeader(title: 'Live Location', trailing: _LiveDot()),
            const SizedBox(height: 8),
            _LiveLocationCard(isCompact: isCompact),
            const SizedBox(height: 4),
            const Text(
              'Your location is being shared with emergency\nservices and contacts',
              style: TextStyle(fontSize: 12, color: Color(0xFF667085)),
            ),

            const SizedBox(height: 16),

            // Emergency Services
            const _SectionHeader(title: 'Emergency Services'),
            const SizedBox(height: 8),
            const _ServiceItem(
              icon: Icons.local_hospital,
              title: 'Ambulance',
              status: 'Dispatched',
              eta: 'ETA: 8 mins',
              active: true,
            ),
            const SizedBox(height: 8),
            const _ServiceItem(
              icon: Icons.local_police,
              title: 'Police',
              status: 'Notified',
              eta: 'ETA: 12 mins',
              active: true,
            ),
            const SizedBox(height: 8),
            const _ServiceItem(
              icon: Icons.local_fire_department,
              title: 'Fire Dept',
              status: 'On Standby',
              eta: 'ETA: 15 mins',
              active: true,
            ),

            const SizedBox(height: 16),

            // Emergency Contacts
            const _SectionHeader(title: 'Emergency Contacts'),
            const SizedBox(height: 8),
            const _ContactItem(initials: 'JD', name: 'John Doe', relation: 'Son', badge: 'Notified', imageUrl: 'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=80&h=80&fit=crop'),
            const SizedBox(height: 8),
            const _ContactItem(initials: 'JS', name: 'Jane Smith', relation: 'Daughter', badge: 'Called', imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=80&h=80&fit=crop'),

            const SizedBox(height: 16),

            // Action buttons
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEB1C24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Cancel Emergency Alert', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 44,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Call Emergency Services', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
              ),
            ),

            const SizedBox(height: 16),

            // Safety Tips
            const _SectionHeader(title: 'Safety Tips'),
            const SizedBox(height: 8),
            const _Bullet(text: 'Stay calm and in a safe location'),
            const _Bullet(text: 'Keep your phone charged and nearby'),
            const _Bullet(text: 'Follow instructions from emergency responders'),

            const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _SOSFab(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, '/consult');
          } else if (i == 2) {
            // already on SOS
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, '/records');
          } else if (i == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 24);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const _SectionHeader({required this.title, this.trailing});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.circle, size: 10, color: Color(0xFF16A34A)),
        SizedBox(width: 6),
        Text('Live', style: TextStyle(fontSize: 12, color: Color(0xFF16A34A), fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _LiveLocationCard extends StatelessWidget {
  final bool isCompact;
  const _LiveLocationCard({required this.isCompact});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            height: isCompact ? 120 : 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFFEFF6FF), Color(0xFFE7F0FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.location_on, color: Color(0xFFEB1C24), size: 28),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 4))],
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.place_outlined, size: 16, color: Color(0xFF667085)),
                    SizedBox(width: 6),
                    Text('123 Main St, New Delhi', style: TextStyle(fontSize: 12, color: Color(0xFF101828))),
                  ],
                ),
              ),
              const Spacer(),
              const _LiveDot(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData? icon;
  final String? imageUrl;
  final String title;
  final String status;
  final String eta;
  final bool active;
  const _ServiceItem({this.icon, this.imageUrl, required this.title, required this.status, required this.eta, required this.active});
  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: const Color(0xFFE7F0FF), borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: hasImage
                  ? Image.network(
                      imageUrl!,
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(icon ?? Icons.local_hospital_outlined, color: const Color(0xFF084BBB)),
                    )
                  : Icon(icon ?? Icons.local_hospital_outlined, color: const Color(0xFF084BBB)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                const SizedBox(height: 2),
                Text(status, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(eta, style: const TextStyle(fontSize: 12, color: Color(0xFF475467), fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFAF0),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle, size: 14, color: Color(0xFF16A34A)),
                    SizedBox(width: 4),
                    Text('Active', style: TextStyle(fontSize: 11, color: Color(0xFF16A34A), fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final String initials;
  final String name;
  final String relation;
  final String badge;
  final String? imageUrl;
  const _ContactItem({required this.initials, required this.name, required this.relation, required this.badge, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          _Avatar(initials: initials, imageUrl: imageUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
                    const SizedBox(width: 8),
                    _Badge(text: badge),
                  ],
                ),
                const SizedBox(height: 2),
                Text(relation, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: const Color(0xFFE7F0FF), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.phone_outlined, color: Color(0xFF0A63E0)),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final String? imageUrl;
  const _Avatar({required this.initials, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: hasImage
            ? Image.network(
                imageUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Text(initials, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF667085))),
                ),
              )
            : Center(
                child: Text(initials, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF667085))),
              ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});
  @override
  Widget build(BuildContext context) {
    final color = text.toLowerCase().contains('called') ? const Color(0xFF0A63E0) : const Color(0xFF667085);
    final bg = text.toLowerCase().contains('called') ? const Color(0xFFE7F0FF) : const Color(0xFFF2F4F7);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w700)),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 14, color: Color(0xFF667085))),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Color(0xFF667085)))),
      ],
    );
  }
}

class _SOSFab extends StatelessWidget {
  const _SOSFab();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        heroTag: 'bottom-sos',
        onPressed: () {
          // already on SOS page
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