import 'package:flutter/material.dart';
import 'video_call_screen.dart';

class ConnectingScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String imageUrl;
  
  const ConnectingScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.imageUrl,
  });

  @override
  State<ConnectingScreen> createState() => _ConnectingScreenState();
}

class _ConnectingScreenState extends State<ConnectingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  int _dots = 0;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat(reverse: true);
    
    // Animate dots
    _animateDots();
    
    // Navigate to video call screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VideoCallScreen(
              doctorName: widget.doctorName,
              specialty: widget.specialty,
              imageUrl: widget.imageUrl,
            ),
          ),
        );
      }
    });
  }

  void _animateDots() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _dots = (_dots + 1) % 4;
        });
        _animateDots();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF007AFF),
      body: Column(
        children: [
          // Status bar space for date/time
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          Expanded(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Text(
                        'Connecting',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
            
            const Spacer(),
            
            // Doctor avatar with pulse animation
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(72),
                      child: Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white.withOpacity(0.2),
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Doctor info
            Text(
              widget.doctorName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              widget.specialty,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Connecting text with animated dots
            Text(
              'Connecting${'.' * _dots}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Loading indicator
            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
            
            const Spacer(),
            
            // Bottom message
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Please wait while we connect you with the doctor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}