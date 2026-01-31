import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _relation;

  final List<String> _relations = [
    'Parent',
    'Spouse',
    'Sibling',
    'Friend',
    'Guardian',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
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
                  'Emergency Contact',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add someone to contact during\nemergencies',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF667085),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Contact Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _inputField(
                  controller: _nameController,
                  hint: 'Enter full name',
                  icon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter name' : null,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Relation',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _relationField(),
                const SizedBox(height: 16),
                const Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _inputField(
                  controller: _phoneController,
                  hint: 'Enter phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Please enter phone number';
                    final digits = v.replaceAll(RegExp(r'\D'), '');
                    if (digits.length < 10) return 'Enter valid phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Your Location',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const _LocationPreview(),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveAndVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A63E0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save & Verify',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveAndVerify() {
    if (_formKey.currentState!.validate() && _relation != null) {
      // Success popup (SnackBar) remove karyu — direct navigate
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (_relation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select relation')),
        );
      }
    }
  }
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    final isCompact = MediaQuery.of(context).size.width < 360;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF667085)),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF667085)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xFF0A63E0), width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xFF0A63E0), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: isCompact ? 14 : 18),
      ),
    );
  }

  Widget _relationField() {
    final isCompact = MediaQuery.of(context).size.width < 360;
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: _relation,
      items: _relations
          .map(
            (r) => DropdownMenuItem<String>(
              value: r,
              child: Text(r, style: const TextStyle(fontSize: 13, color: Colors.black87)),
            ),
          )
          .toList(),
      onChanged: (v) => setState(() => _relation = v),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.groups_2_outlined, color: Color(0xFF667085)),
        hintText: 'Select relation',
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF667085)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xFF0A63E0), width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Color(0xFF0A63E0), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: isCompact ? 14 : 18),
      ),
    );
  }
}

class _LocationPreview extends StatelessWidget {
  const _LocationPreview();

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 360;
    return Container(
      height: isCompact ? 100 : 120,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(
          BorderSide(color: Color(0xFF0A63E0), width: 1.5),
        ),
      ),
      child: CustomPaint(
        painter: _GridPainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE7F0FF),
                child: Icon(Icons.location_on_outlined, color: Color(0xFF0A63E0)),
              ),
              SizedBox(height: 8),
              Text(
                'Location will be shared\nduring emergencies',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFF667085)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    const cell = 16.0;
    for (double x = 0; x < size.width; x += cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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