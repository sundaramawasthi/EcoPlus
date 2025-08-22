import 'package:flutter/material.dart';

class AppTheme {
  // --- Colors ---
  static const Color primary = Color(0xFF22A06B);
  static const Color primaryDark = Color(0xFF1B7A52);
  static const Color dark = Color(0xFF222222);
  static const Color lightBg = Color(0xFFEFF8F2);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFE53935);

  // --- Light Theme ---
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Arial",
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: primaryDark,
      background: lightBg,
      error: error,
    ),
    scaffoldBackgroundColor: lightBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 15, color: Colors.black87),
      bodySmall: TextStyle(fontSize: 13, color: Colors.black54),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: lightGrey,
      labelStyle: const TextStyle(color: Colors.black87),
      secondaryLabelStyle: const TextStyle(color: Colors.black87),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      secondarySelectedColor: primaryDark,
      selectedColor: primary,
    ),
  );
}
