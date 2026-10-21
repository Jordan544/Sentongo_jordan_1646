import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const POSApp());
}

class POSApp extends StatelessWidget {
  const POSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golden POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Defining the Golden/Orange Theme
        primaryColor: const Color(0xFFF57C00), // Deep Orange
        scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Soft Cream Background
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB300), // Amber Gold
          primary: const Color(0xFFF57C00),
          secondary: const Color(0xFFFFB300),
          background: const Color(0xFFFFF8E1),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF212121),
          elevation: 0,
        ),
        // Customizing Cards to look modern
        cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: const Color(0xFFFFB300).withOpacity(0.3), // Golden shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
  ),
),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF57C00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}