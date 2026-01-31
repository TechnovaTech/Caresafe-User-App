import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_filled,
              label: 'Home',
              index: 0,
              selected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.medical_services_outlined,
              label: 'Consult',
              index: 1,
              selected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            const SizedBox(width: 68),
            _NavItem(
              icon: Icons.folder_open,
              label: 'Records',
              index: 3,
              selected: currentIndex == 3,
              onTap: () => onTap(3),
            ),
            _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              index: 4,
              selected: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

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