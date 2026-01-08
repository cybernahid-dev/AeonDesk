import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AeonDeskApp());
}

class AeonDeskApp extends StatelessWidget {
  const AeonDeskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AeonDesk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E14), // Deep Cyber Dark
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF), // Cyber Blue
          secondary: Color(0xFF2979FF),
          surface: Color(0xFF161B22),
        ),
        textTheme: GoogleFonts.jetbrainsMonoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
