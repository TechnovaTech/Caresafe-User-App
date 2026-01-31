import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D79F2), // top light blue
              Color(0xFF0A63E0), // bottom deep blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _AppIcon(),
              const SizedBox(height: 32),
              const Text(
                'CareSafe',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Healthcare & SOS Assistance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 80),
              const _PageDots(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.favorite,
            size: 50,
            color: Colors.white,
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(opacity: 0.55),
        const SizedBox(width: 8),
        _dot(opacity: 0.95, size: 8),
        const SizedBox(width: 8),
        _dot(opacity: 0.55),
      ],
    );
  }

  Widget _dot({double opacity = 0.75, double size = 6}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}