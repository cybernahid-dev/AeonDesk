import 'package:flutter/material.dart';
import 'dart:ui';
import '../services/installer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isInstalled = false;
  bool isWorking = false;
  String status = "CORE SYSTEM STANDBY";
  double loadFactor = 0.0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF00E5FF); // Neon Cyan

    return Scaffold(
      backgroundColor: const Color(0xFF020408),
      body: Stack(
        children: [
          // 1. Animated Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(themeColor.withOpacity(0.1), 300),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildBlurCircle(Colors.blueAccent.withOpacity(0.05), 250),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  _buildHeader(themeColor),
                  const SizedBox(height: 40),

                  // --- Central Visualizer ---
                  Expanded(
                    child: Center(
                      child: _buildCentralHexagon(themeColor),
                    ),
                  ),

                  // --- Functional Dashboard ---
                  _buildDashboard(themeColor),
                  const SizedBox(height: 25),

                  // --- Pro Action Button ---
                  _buildActionButton(themeColor),
                  const SizedBox(height: 15),
                  
                  const Center(
                    child: Text(
                      "AEONCOREX VIRTUALIZATION ENGINE // V1.0",
                      style: TextStyle(color: Colors.white24, fontSize: 8, letterSpacing: 2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildHeader(Color themeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AEON_DESK", style: TextStyle(color: themeColor, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4)),
            const Text("UNIFIED LINUX INTERFACE", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.5)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: themeColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text("ENCRYPTED", style: TextStyle(color: Colors.greenAccent, fontSize: 8)),
        )
      ],
    );
  }

  Widget _buildCentralHexagon(Color themeColor) {
    return FadeTransition(
      opacity: _pulseController,
      child: Container(
        height: 220,
        width: 220,
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Minimalist alternative to Hexagon
          border: Border.all(color: themeColor.withOpacity(0.2), width: 2),
          boxShadow: [
            BoxShadow(color: themeColor.withOpacity(0.1), blurRadius: 40, spreadRadius: 10),
          ],
        ),
        child: Icon(Icons.security, size: 100, color: themeColor),
      ),
    );
  }

  Widget _buildDashboard(Color themeColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            children: [
              _buildStatRow("KERNEL", isInstalled ? "AARCH64" : "UNKNOWN"),
              const SizedBox(height: 12),
              _buildStatRow("ENVIRONMENT", isInstalled ? "XFCE_DESKTOP" : "NULL"),
              const SizedBox(height: 12),
              _buildStatRow("STATUS", status),
              if (isWorking) ...[
                const SizedBox(height: 20),
                LinearProgressIndicator(backgroundColor: Colors.white10, color: themeColor, minHeight: 1),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildActionButton(Color themeColor) {
    return GestureDetector(
      onTap: isWorking ? null : () async {
        setState(() => isWorking = true);
        await InstallerService().installLinux((msg) {
          setState(() {
            status = msg.toUpperCase();
            if (msg.contains("Complete")) {
              isInstalled = true;
              isWorking = false;
            }
          });
        });
      },
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [themeColor, themeColor.withOpacity(0.7)]),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Center(
          child: Text(
            isInstalled ? "LAUNCH DESKTOP" : "INITIALIZE ENVIRONMENT",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
