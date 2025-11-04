import 'package:flutter/material.dart';

class ThemeConfig {
  // Dark Theme Colors (Epic Fantasy)
  static const Color darkPrimary = Color(0xFFD4AF37);
  static const Color darkSecondary = Color(0xFF8B4513);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkBackground = Color(0xFF0F0F1E);

  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF8B6914);
  static const Color lightSecondary = Color(0xFF654321);
  static const Color lightSurface = Color(0xFFF5F5F0);
  static const Color lightBackground = Color(0xFFFFFFFF);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkSecondary,
        surface: darkSurface,
        background: darkBackground,
      ),
      scaffoldBackgroundColor: darkBackground,
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 8,
        shadowColor: darkPrimary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkPrimary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: darkBackground,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightSecondary,
        surface: lightSurface,
        background: lightBackground,
      ),
      scaffoldBackgroundColor: lightBackground,
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: lightPrimary.withOpacity(0.3), width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseColor = brightness == Brightness.dark ? Colors.white : Colors.black87;
    return TextTheme(
      displayLarge: TextStyle(fontFamily: 'Cinzel', fontSize: 32, fontWeight: FontWeight.bold, color: baseColor),
      headlineMedium: TextStyle(fontFamily: 'Cinzel', fontSize: 24, fontWeight: FontWeight.w600, color: baseColor),
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: baseColor),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: baseColor.withOpacity(0.7)),
    );
  }
}
