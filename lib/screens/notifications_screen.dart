import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool emergencyAlerts = true;
  bool appointmentReminders = true;
  bool healthTips = true;

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
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
            const SizedBox(height: 24), // top spacing under app bar for perfect look
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
                  const SizedBox(height: 12),
                  _PrefRow(
                    icon: Icons.warning_amber_outlined,
                    title: 'Emergency alerts',
                    subtitle: 'Critical safety updates',
                    value: emergencyAlerts,
                    onChanged: (v) => setState(() => emergencyAlerts = v),
                  ),
                  const SizedBox(height: 12),
                  _PrefRow(
                    icon: Icons.event_available_outlined,
                    title: 'Appointment reminders',
                    subtitle: 'Upcoming visits and follow-ups',
                    value: appointmentReminders,
                    onChanged: (v) => setState(() => appointmentReminders = v),
                  ),
                  const SizedBox(height: 12),
                  _PrefRow(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Health tips',
                    subtitle: 'Daily wellness suggestions',
                    value: healthTips,
                    onChanged: (v) => setState(() => healthTips = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Recent', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
                  SizedBox(height: 12),
                  _RecentItem(
                    icon: Icons.warning_amber_outlined,
                    title: 'Emergency Services Notified',
                    subtitle: 'Your SOS is active. Help is on the way.',
                  ),
                  SizedBox(height: 12),
                  _RecentItem(
                    icon: Icons.event_available_outlined,
                    title: 'Appointment Confirmed',
                    subtitle: 'Dr. Smith - Today at 4:30 PM.',
                  ),
                  SizedBox(height: 12),
                  _RecentItem(
                    icon: Icons.notifications_none,
                    title: 'Health Tip',
                    subtitle: 'Stay hydrated. Aim for 8 glasses today.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }
}

class _PrefRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _PrefRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: const Color(0xFFE7F0FF), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: const Color(0xFF0A63E0)),
        ),
        const SizedBox(width: 12),
        const SizedBox(),
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
        _Toggle(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _Toggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _Toggle({required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 52,
        height: 28,
        decoration: BoxDecoration(
          color: value ? const Color(0xFF0A63E0) : const Color(0xFFE4E7EC),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 20,
            height: 20,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Center(
              child: Text(value ? 'On' : 'Off', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.black87)),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _RecentItem({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: const Color(0xFFE7F0FF), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: const Color(0xFF0A63E0)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF667085))),
            ],
          ),
        ),
      ],
    );
  }
}