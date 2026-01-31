import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'doctor_detail_screen.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  int _selectedCategory = 0; // 0: All
  final List<String> _categories = ['All', 'General', 'Cardiology', 'Dermatology'];

  // Search state
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // Data
  late final List<_Doctor> _doctors;
  List<_Doctor> _filtered = [];

  @override
  void initState() {
    super.initState();
    _doctors = const [
      _Doctor(
        name: 'Dr. Priya Sharma',
        role: 'General Physician',
        online: true,
        rating: 4.9,
        years: 8,
        price: 500,
        imageUrl: 'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=256&h=256&fit=crop',
      ),
      _Doctor(
        name: 'Dr. Kevin Chen',
        role: 'Cardiologist',
        online: true,
        rating: 4.8,
        years: 12,
        price: 800,
        imageUrl: 'https://images.unsplash.com/photo-1594824476961-33e0664f10be?w=256&h=256&fit=crop',
      ),
      _Doctor(
        name: 'Dr. Emily Watson',
        role: 'Dermatologist',
        online: false,
        rating: 4.7,
        years: 6,
        price: 600,
        imageUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=256&h=256&fit=crop',
      ),
      _Doctor(
        name: 'Dr. Omar Hassan',
        role: 'Neurologist',
        online: true,
        rating: 4.9,
        years: 15,
        price: 1000,
        imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=256&h=256&fit=crop',
      ),
    ];
    _filtered = List<_Doctor>.from(_doctors);
  }

  void _applyFilters() {
    final q = _query.trim().toLowerCase();
    final selectedCat = _selectedCategory;
    setState(() {
      _filtered = _doctors.where((d) {
        final matchesQuery = q.isEmpty || d.name.toLowerCase().contains(q) || d.role.toLowerCase().contains(q);
        final matchesCategory = selectedCat == 0 ||
            (selectedCat == 1 && d.role.toLowerCase().contains('general')) ||
            (selectedCat == 2 && d.role.toLowerCase().contains('cardio')) ||
            (selectedCat == 3 && d.role.toLowerCase().contains('derma'));
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              'Find a Doctor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            const Text(
              'Book appointments with specialists',
              style: TextStyle(fontSize: 14, color: Color(0xFF667085)),
            ),
            const SizedBox(height: 14),
            _SearchBar(
              isCompact: isCompact,
              controller: _searchController,
              onChanged: (v) {
                _query = v;
                _applyFilters();
              },
            ),
            const SizedBox(height: 12),
            _CategoryChips(
              categories: _categories,
              selectedIndex: _selectedCategory,
              onSelected: (i) {
                _selectedCategory = i;
                _applyFilters();
              },
            ),
            const SizedBox(height: 6),
            Container(height: 2, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            ..._filtered.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoctorDetailScreen(
                            name: d.name,
                            role: d.role,
                            online: d.online,
                            rating: d.rating,
                            years: d.years,
                            price: d.price,
                            imageUrl: d.imageUrl,
                          ),
                        ),
                      );
                    },
                    child: _DoctorCard(
                      name: d.name,
                      role: d.role,
                      online: d.online,
                      rating: d.rating,
                      years: d.years,
                      price: d.price,
                      isCompact: isCompact,
                      imageUrl: d.imageUrl,
                    ),
                  ),
                )),
            const SizedBox(height: 90), // space above bottom bar
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _SOSFab(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (i == 1) {
            // already on Consult
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, '/records');
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

class _StatusBar extends StatelessWidget {
  const _StatusBar();
  @override
  Widget build(BuildContext context) {
    // Space for date & time navbar at the top
    return const SizedBox(height: 24);
  }
}

class _Doctor {
  final String name;
  final String role;
  final bool online;
  final double rating;
  final int years;
  final int price;
  final String imageUrl;
  const _Doctor({
    required this.name,
    required this.role,
    required this.online,
    required this.rating,
    required this.years,
    required this.price,
    required this.imageUrl,
  });
}

class _SearchBar extends StatelessWidget {
  final bool isCompact;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.isCompact, required this.controller, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: isCompact ? 6 : 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 8, offset: Offset(0, 2))],
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF667085)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Search doctors, specialization',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: isCompact ? 13 : 14, color: const Color(0xFF101828)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: isCompact ? 44 : 48,
          height: isCompact ? 44 : 48,
          decoration: BoxDecoration(
            color: const Color(0xFF0A63E0),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const _CategoryChips({required this.categories, required this.selectedIndex, required this.onSelected});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return InkWell(
            onTap: () => onSelected(index),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFE7F0FF) : const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: selected ? const Color(0xFF0A63E0) : Colors.transparent),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? const Color(0xFF0A63E0) : const Color(0xFF667085),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String name;
  final String role;
  final bool online;
  final double rating;
  final int years;
  final int price;
  final bool isCompact;
  final String imageUrl;
  const _DoctorCard({
    required this.name,
    required this.role,
    required this.online,
    required this.rating,
    required this.years,
    required this.price,
    required this.isCompact,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x12000000), blurRadius: 10, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              width: isCompact ? 52 : 60,
              height: isCompact ? 52 : 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: isCompact ? 52 : 60,
                height: isCompact ? 52 : 60,
                color: const Color(0xFFE7F0FF),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF0A63E0),
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: online ? const Color(0xFFE7F9ED) : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
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
                  ],
                ),
                const SizedBox(height: 4),
                Text(role, style: const TextStyle(fontSize: 13, color: Color(0xFF667085))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                    const SizedBox(width: 4),
                    Text('$rating', style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 6),
                    const Text('•', style: TextStyle(color: Color(0xFF98A2B3))),
                    const SizedBox(width: 6),
                    Text('$years years', style: const TextStyle(fontSize: 13, color: Color(0xFF667085))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text('₹$price', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0A63E0))),
          ),
        ],
      ),
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
        heroTag: 'bottom-sos-consult',
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