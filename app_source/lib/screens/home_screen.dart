import 'package:flutter/material.dart';
import '../services/installer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInstalled = false;
  String status = "SYSTEM READY";
  double progress = 0.0;
  bool isWorking = false;

  void updateStatus(String msg) {
    setState(() {
      status = msg.toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A0E), // Ultra Dark
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [const Color(0xFF00E5FF).withOpacity(0.05), Colors.transparent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- AEON LOGO AREA ---
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withOpacity(0.2 * value),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.5), width: 1),
                      ),
                      child: const Icon(Icons.blur_on, size: 80, color: Color(0xFF00E5FF)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                "AEON DESK",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 8, color: Colors.white),
              ),
              const Text(
                "LINUX ENVIRONMENT PLATFORM",
                style: TextStyle(fontSize: 10, letterSpacing: 2, color: Color(0xFF00E5FF)),
              ),
              const SizedBox(height: 60),

              // --- STATUS BOX ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("CORE_STATUS", style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Text(isInstalled ? "READY" : "STANDBY", style: const TextStyle(fontSize: 10, color: Colors.cyanAccent)),
                      ],
                    ),
                    const Divider(height: 25, color: Colors.white10),
                    Text(status, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white)),
                    if (isWorking) ...[
                      const SizedBox(height: 15),
                      const LinearProgressIndicator(
                        backgroundColor: Colors.white10,
                        color: Color(0xFF00E5FF),
                        minHeight: 2,
                      ),
                    ]
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- ACTION BUTTON ---
              GestureDetector(
                onTap: isWorking ? null : () async {
                  setState(() => isWorking = true);
                  await InstallerService().installLinux((msg) {
                    setState(() {
                      status = msg;
                      if (msg.contains("Complete")) {
                        isInstalled = true;
                        isWorking = false;
                      }
                    });
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isWorking ? Colors.transparent : const Color(0xFF00E5FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF00E5FF)),
                  ),
                  child: Center(
                    child: Text(
                      isInstalled ? "LAUNCH INTERFACE" : "INITIALIZE CORE",
                      style: TextStyle(
                        color: isWorking ? const Color(0xFF00E5FF) : Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("DEVELOPED BY AEONCOREX TEAM // INTERNAL USE ONLY", 
                style: TextStyle(fontSize: 8, color: Colors.white24)),
            ],
          ),
        ),
      ),
    );
  }
}
