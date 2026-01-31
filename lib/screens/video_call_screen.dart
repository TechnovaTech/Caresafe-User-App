import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String imageUrl;
  
  const VideoCallScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.imageUrl,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  String _callDuration = "00:42";

  @override
  void initState() {
    super.initState();
    _startCallTimer();
  }

  void _startCallTimer() {
    // Simulate call timer
    int seconds = 42;
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        seconds++;
        int minutes = seconds ~/ 60;
        int remainingSeconds = seconds % 60;
        setState(() {
          _callDuration = "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
        });
        _startCallTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Status bar space for date/time
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.white,
          ),
          Expanded(
            child: Stack(
              children: [
          // Doctor's video background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF007AFF),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.3),
                    BlendMode.overlay,
                  ),
                  onError: (error, stackTrace) {},
                ),
              ),
              child: widget.imageUrl.isEmpty ? Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0xFF007AFF),
                    ],
                  ),
                ),
              ) : null,
            ),
          ),
          
          // Top status bar
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Connected',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          // Call duration
          Positioned(
            top: 50,
            right: 20,
            child: Text(
              _callDuration,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Doctor name at top
          Positioned(
            top: 80,
            left: 20,
            child: Text(
              widget.doctorName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Your video preview (small window)
          Positioned(
            top: 120,
            right: 20,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 8,
                    right: 8,
                    child: Text(
                      'You',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Doctor info at bottom
          Positioned(
            bottom: 140,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.doctorName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.specialty,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom control buttons
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMuted = !_isMuted;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isMuted ? Colors.red : Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      _isMuted ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // Video toggle button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVideoOff = !_isVideoOff;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isVideoOff ? Colors.red : Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      _isVideoOff ? Icons.videocam_off : Icons.videocam,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // End call button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // Camera switch button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.cameraswitch,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                // More options button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
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