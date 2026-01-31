import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: Column(
        children: [
          // Status bar space for date/time
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          // App bar
          Container(
            color: const Color(0xFFF7F9FC),
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
            child: const Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                _ProfileItem(
                  icon: Icons.settings_outlined,
                  title: 'Profile Settings',
                  onTap: () => Navigator.pushNamed(context, '/profile-settings'),
                ),
                const SizedBox(height: 12),
                _ProfileItem(
                  icon: Icons.groups_outlined,
                  title: 'Emergency Contacts',
                  onTap: () => Navigator.pushNamed(context, '/consult'),
                ),
                const SizedBox(height: 12),
                _ProfileItem(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Health History',
                  onTap: () => Navigator.pushNamed(context, '/records'),
                ),
                const SizedBox(height: 12),
                _ProfileItem(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  onTap: () => Navigator.pushNamed(context, '/notifications'),
                ),
                const SizedBox(height: 12),
                const _ProfileItem(icon: Icons.tune, title: 'App Settings'),
                const SizedBox(height: 12),
                _ProfileItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const _SOSFab(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 8),
        child: BottomNavBar(
          currentIndex: 4,
          onTap: (i) {
            if (i == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (i == 1) {
              Navigator.pushReplacementNamed(context, '/consult');
            } else if (i == 2) {
              Navigator.pushReplacementNamed(context, '/sos');
            } else if (i == 3) {
              Navigator.pushReplacementNamed(context, '/records');
            } else if (i == 4) {
              // already on profile
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coming soon')));
            }
          },
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  const _ProfileItem({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
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
              child: Icon(icon, color: const Color(0xFF0A63E0)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF98A2B3)),
          ],
        ),
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
        heroTag: 'bottom-sos',
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/sos');
        },
        backgroundColor: const Color(0xFFEB1C24),
        elevation: 4,
        shape: const CircleBorder(),
        child: const Text('SOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
      ),
    );
  }
}