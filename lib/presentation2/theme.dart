import 'package:flutter/material.dart';

class AppTheme {
  // Primary color palette
  static const MaterialColor _primarySwatch = Colors.blue;

  static ThemeData light() {
    return ThemeData(
      primarySwatch: _primarySwatch,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[50],
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black45),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primarySwatch: _primarySwatch,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[900],
      cardColor: Color(0xFF1E1E1E),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
    );
  }
}

