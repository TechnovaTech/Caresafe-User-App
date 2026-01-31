import 'package:flutter/material.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _location = false;
  bool _microphone = false;
  bool _motion = false;
  bool _terms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _StatusBar(),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: _BackButton(onTap: () => Navigator.pop(context)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Permissions Required',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Allow access to enable emergency features',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF667085),
                ),
              ),
              const SizedBox(height: 24),
              PermissionCard(
                icon: Icons.location_on_outlined,
                title: 'Location Access',
                subtitle: 'To send your location during\nemergencies',
                checked: _location,
                onChanged: (v) => setState(() => _location = v),
              ),
              const SizedBox(height: 16),
              PermissionCard(
                icon: Icons.mic_none_outlined,
                title: 'Microphone Access',
                subtitle: 'For voice-activated SOS and\nvideo calls',
                checked: _microphone,
                onChanged: (v) => setState(() => _microphone = v),
              ),
              const SizedBox(height: 16),
              PermissionCard(
                icon: Icons.show_chart,
                title: 'Motion Sensors',
                subtitle: 'To detect falls and unusual\nmovements',
                checked: _motion,
                onChanged: (v) => setState(() => _motion = v),
              ),
              const SizedBox(height: 24),
              // Terms consent block (4th round checkbox)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _CheckBadge(
                          checked: _terms,
                          onTap: () => setState(() => _terms = !_terms),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                              children: [
                                TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(color: Color(0xFF0A63E0), fontWeight: FontWeight.w700),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: Color(0xFF0A63E0), fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your data will be kept secure and confidential',
                      style: TextStyle(fontSize: 13, color: Color(0xFF98A2B3)),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/emergency');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A63E0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool checked;
  final ValueChanged<bool> onChanged;
  const PermissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.checked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;
        final iconBoxSize = isCompact ? 38.0 : 44.0;
        final badgeSize = isCompact ? 32.0 : 36.0;
        final borderWidth = checked ? 1.5 : 1.0;
        return InkWell(
          onTap: () => onChanged(!checked),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(isCompact ? 12 : 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: checked
                    ? const Color(0xFF0A63E0)
                    : const Color(0xFF0A63E0).withOpacity(0.25),
                width: borderWidth,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: iconBoxSize,
                  height: iconBoxSize,
                  decoration: BoxDecoration(
                    color: checked
                        ? const Color(0xFF0A63E0).withOpacity(0.24)
                        : const Color(0xFF0A63E0).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: checked
                          ? const Color(0xFF0A63E0)
                          : const Color(0xFF0A63E0).withOpacity(0.25),
                      width: checked ? 1.2 : 1.0,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF0A63E0),
                    size: isCompact ? 20 : 22,
                  ),
                ),
                SizedBox(width: isCompact ? 10 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style:
                            const TextStyle(fontSize: 13, color: Color(0xFF667085)),
                      ),
                    ],
                  ),
                ),
                _CheckBadge(checked: checked, onTap: () => onChanged(!checked), size: badgeSize),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CheckBadge extends StatelessWidget {
  final bool checked;
  final VoidCallback? onTap;
  final double? size;
  const _CheckBadge({required this.checked, this.onTap, this.size});
  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 360;
    final s = size ?? (isCompact ? 32.0 : 36.0);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s / 2),
      child: Container(
        width: s,
        height: s,
        decoration: BoxDecoration(
          color: checked
              ? const Color(0xFF0A63E0)
              : const Color(0xFF0A63E0).withOpacity(0.15),
          borderRadius: BorderRadius.circular(s / 2),
          border: Border.all(
            color: checked
                ? const Color(0xFF0A63E0)
                : const Color(0xFF0A63E0).withOpacity(0.30),
            width: checked ? 1.4 : 1.0,
          ),
        ),
        child: checked
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: s * 0.55,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 44);
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
      ),
    );
  }
}