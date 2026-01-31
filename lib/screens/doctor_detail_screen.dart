import 'package:flutter/material.dart';
import 'connecting_screen.dart';

class DoctorDetailScreen extends StatelessWidget {
  final String name;
  final String role;
  final bool online;
  final double rating;
  final int years;
  final int price;
  final String imageUrl;

  const DoctorDetailScreen({
    super.key,
    required this.name,
    required this.role,
    required this.online,
    required this.rating,
    required this.years,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _StatusBar(),
                  const SizedBox(height: 8),
                  // Header image with rounded bottom and availability chip
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: Image.network(
                          imageUrl,
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (_, __, ___) => Container(
                            height: 240,
                            color: const Color(0xFFE7F0FF),
                            alignment: Alignment.center,
                            child: const Icon(Icons.person, size: 48, color: Color(0xFF0A63E0)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: online ? const Color(0xFFE7F9ED) : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: online ? const Color(0xFF16A34A) : const Color(0xFF98A2B3)),
                          ),
                          child: Text(
                            online ? 'Available Now' : 'Offline',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: online ? const Color(0xFF16A34A) : const Color(0xFF667085),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Name card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          Text(role, style: const TextStyle(fontSize: 14, color: Color(0xFF667085))),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                              const SizedBox(width: 4),
                              Text('$rating', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              const SizedBox(width: 6),
                              const Text('(234 reviews)', style: TextStyle(fontSize: 12, color: Color(0xFF667085))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Info chips row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _InfoChip(icon: Icons.watch_later_outlined, title: '$years years', subtitle: 'Experience'),
                        const SizedBox(width: 10),
                        const _InfoChip(icon: Icons.school_outlined, title: 'MD', subtitle: 'Degree'),
                        const SizedBox(width: 10),
                        const _InfoChip(icon: Icons.people_alt_outlined, title: '234', subtitle: 'Reviews'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // About
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _SectionCard(
                      title: 'About',
                      child: const Text(
                        'Dr. Priya Sharma is a highly experienced general physician with expertise in treating common illnesses, preventive care, and chronic disease management.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF667085)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Hospital
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _SectionCard(
                      title: 'Hospital',
                      child: Row(
                        children: const [
                          Icon(Icons.local_hospital_outlined, color: Color(0xFF0A63E0)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Apollo Hospital, Delhi\nMBBS, MD - General Medicine',
                              style: TextStyle(fontSize: 14, color: Color(0xFF667085)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 90), // space above bottom bar
                ],
              ),
            ),

            // Back button overlay
            Positioned(
              left: 12,
              top: 60,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom booking bar
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, -4))],
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Consultation Fee', style: TextStyle(fontSize: 12, color: Color(0xFF667085))),
                    const SizedBox(height: 4),
                    Text('₹$price', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF101828))),
                  ],
                ),
              ),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConnectingScreen(
                          doctorName: name,
                          specialty: role,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A63E0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Book Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoChip({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF0A63E0)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF667085))),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: child,
        ),
      ],
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