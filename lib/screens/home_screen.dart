import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

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
            const SizedBox(height: 12),
            _GreetingCard(isCompact: isCompact),
            const SizedBox(height: 16),
            _BigSOS(isCompact: isCompact),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.mic_none_outlined, size: 16, color: Color(0xFF667085)),
                SizedBox(width: 6),
                Text(
                  "Tap or say \"Help\" to send SOS",
                  style: TextStyle(fontSize: 13, color: Color(0xFF475467)),
                )
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            _QuickActions(isCompact: isCompact),
            const SizedBox(height: 16),
            _EmergencyReadiness(isCompact: isCompact),
            const SizedBox(height: 16),
            _HealthTips(isCompact: isCompact),
            const SizedBox(height: 90), // space above bottom bar
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _SOSFab(),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _tabIndex,
        onTap: (i) {
          if (i == 1) {
            Navigator.pushReplacementNamed(context, '/consult');
          } else if (i == 0) {
            if (_tabIndex != 0) setState(() => _tabIndex = 0);
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, '/records');
          } else if (i == 4) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else {
            setState(() => _tabIndex = i);
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
    // Mobile status bar jevi upar ni khālī space
    return const SizedBox(height: 24);
  }
}

class _GreetingCard extends StatelessWidget {
  final bool isCompact;
  const _GreetingCard({required this.isCompact});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A63E0),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good morning,',
                  style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'John Doe',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Stay safe and healthy',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.pushNamed(context, '/notifications'),
              child: const Icon(Icons.notifications_none, color: Color(0xFF0A63E0)),
            ),
          )
        ],
      ),
    );
  }
}

class _BigSOS extends StatefulWidget {
  final bool isCompact;
  const _BigSOS({required this.isCompact});
  @override
  State<_BigSOS> createState() => _BigSOSState();
}

class _BigSOSState extends State<_BigSOS> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse1;
  late final Animation<double> _pulse2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat(reverse: false);
    _pulse1 = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _pulse2 = CurvedAnimation(parent: _controller, curve: const Interval(0.25, 1.0, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size ane animation intensity thoduk nīchi kari
    final size = widget.isCompact ? 150.0 : 170.0; // pehla 170/190
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated outer ripples
          AnimatedBuilder(
            animation: _pulse1,
            builder: (context, child) {
              final scale = 1.0 + (_pulse1.value * 0.28); // pehla 0.35
              final opacity = (1.0 - _pulse1.value).clamp(0.0, 1.0);
              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity * 0.5, // pehla 0.6
                  child: _Ring(size: size + 50, color: const Color(0xFFFF7171)), // pehla +70
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _pulse2,
            builder: (context, child) {
              final scale = 1.0 + (_pulse2.value * 0.18); // pehla 0.25
              final opacity = (1.0 - _pulse2.value).clamp(0.0, 1.0);
              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity * 0.65, // pehla 0.75
                  child: _Ring(size: size + 22, color: const Color(0xFFFF3D3D)), // pehla +30
                ),
              );
            },
          ),
          // Core SOS button
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/sos'),
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Color(0xFFEB1C24),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 6)),
                ],
              ),
              child: const Center(
                child: Text(
                  'SOS',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900), // pehla 28
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double size;
  final Color color;
  const _Ring({required this.size, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final bool isCompact;
  const _QuickActions({required this.isCompact});
  @override
  Widget build(BuildContext context) {
    final spacing = isCompact ? 10.0 : 12.0;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/consult'),
            child: const _QuickItem(
              icon: Icons.medical_services_outlined,
              title: 'Consult a\nDoctor',
              bgColor: Color(0xFF0A63E0), // blue
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/records'),
            child: const _QuickItem(
              icon: Icons.description_outlined,
              title: 'Medical\nRecords',
              bgColor: Color(0xFF16A34A), // green
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/emergency'),
            child: const _QuickItem(
              icon: Icons.group_outlined,
              title: 'Emergency\nContacts',
              bgColor: Color(0xFFF79009), // orange
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color bgColor;
  const _QuickItem({required this.icon, required this.title, required this.bgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _EmergencyReadiness extends StatelessWidget {
  final bool isCompact;
  const _EmergencyReadiness({required this.isCompact});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Emergency Readiness',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
              ),
              Text('70%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.7,
              minHeight: 10,
              color: const Color(0xFF0A63E0),
              backgroundColor: Colors.grey.shade200,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Complete setup to boost your safety.',
            style: TextStyle(fontSize: 13, color: Color(0xFF475467)),
          )
        ],
      ),
    );
  }
}

class _HealthTips extends StatelessWidget {
  final bool isCompact;
  const _HealthTips({required this.isCompact});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Tips',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A63E0), Color(0xFF1E7AF9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 3)),
              ],
            ),
            child: Row(
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Stay Hydrated', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text(
                        'Drink at least 8 glasses of water daily.',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.water_drop, color: Colors.white, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _BottomBar({required this.currentIndex, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10, // perfect notch spacing
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Icons.home_filled, label: 'Home', selected: currentIndex == 0, onTap: () => onTap(0)),
            _NavItem(icon: Icons.medical_services_outlined, label: 'Consult', selected: currentIndex == 1, onTap: () => onTap(1)),
            const SizedBox(width: 68), // space for center FAB (64 + margin)
            _NavItem(icon: Icons.folder_open, label: 'Records', selected: currentIndex == 3, onTap: () => onTap(3)),
            _NavItem(icon: Icons.person_outline, label: 'Profile', selected: currentIndex == 4, onTap: () => onTap(4)),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF0A63E0) : const Color(0xFF667085);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SOSFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        heroTag: 'bottom-sos',
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