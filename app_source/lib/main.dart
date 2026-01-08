import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AeonDeskApp());
}

class AeonDeskApp extends StatelessWidget {
  const AeonDeskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AeonDesk',
      debugShowCheckedModeBanner: false,
      
      // --- THEME CONFIGURATION ---
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020408), // Ultra Deep Blue-Black
        
        // Custom Color Scheme
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),    // Cyber Cyan
          secondary: Color(0xFF2979FF),  // Tech Blue
          surface: Color(0xFF0A0E14),    // Dark Surface
          onPrimary: Colors.black,
        ),

        // Updated TextTheme Logic to fix 'jetbrainsMonoTextTheme' error
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: const Color(0xFF00E5FF),
        ),

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF00E5FF),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      
      // Entry Point
      home: const HomeScreen(),
    );
  }
}
