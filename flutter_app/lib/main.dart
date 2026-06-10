import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StudentManagementApp());
}

class StudentManagementApp extends StatelessWidget {
  const StudentManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B365D), // Thapar Navy Blue Base
          primary: const Color(0xFF1B365D),    // Primary branding color
          secondary: const Color(0xFF8A1538),  // Thapar Crimson Accent for interactions
          brightness: Brightness.light,
          surface: Colors.grey.shade50,        // Clean, uniform background
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        
        // Form Input Fields Customization
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1B365D), width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),

        // Primary Button (Submit Button) Customization
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            backgroundColor: const Color(0xFF8A1538), // Applied Thapar Crimson globally
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFF8A1538).withOpacity(0.6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            elevation: 1,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}