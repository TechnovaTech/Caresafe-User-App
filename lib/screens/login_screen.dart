import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedCountry = 'IN +91';

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Mobile-like status bar
                _StatusBar(),
                const SizedBox(height: 12),
                const SizedBox(height: 24),
                // Header: Logo + Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Logo(),
                    const SizedBox(width: 12),
                    const Text(
                      'CareSafe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your mobile number to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Mobile Number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Fixed +91 prefix capsule (replace dropdown)
                    Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Phone input
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey[600]),
                          prefixIcon: const Icon(Icons.phone_outlined),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Color(0xFF0A63E0), width: 1.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.trim().length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A63E0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Color(0xFF0A63E0),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Move Terms text right below the Create Account row
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                      children: [
                        TextSpan(text: 'By continuing, you agree to our '),
                        TextSpan(
                          text: 'Terms of Service',
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
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              phoneNumber: '+91${_phoneController.text}',
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

// Make navbar only space
class _StatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 44);
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF0A63E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.favorite, color: Colors.white, size: 22),
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(color: Color(0xFFE53935), shape: BoxShape.circle),
              child: const Icon(Icons.add, size: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}