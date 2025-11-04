import 'package:flutter/material.dart';

class ThemeConfig {
  // Color Palette - Dark Theme (Epic Fantasy)
  static const Color darkPrimary = Color(0xFFD4AF37); // Gold
  static const Color darkSecondary = Color(0xFF8B4513); // Bronze
  static const Color darkTertiary = Color(0xFF4A5568); // Steel Gray
  static const Color darkSurface = Color(0xFF1A1A2E); // Dark Blue
  static const Color darkBackground = Color(0xFF0F0F1E); // Darker Blue

  // Color Palette - Light Theme (Holy Kingdom)
  static const Color lightPrimary = Color(0xFF8B6914); // Dark Gold
  static const Color lightSecondary = Color(0xFF654321); // Dark Bronze
  static const Color lightTertiary = Color(0xFF5A6C7D); // Blue Gray
  static const Color lightSurface = Color(0xFFF5F5F0); // Cream
  static const Color lightBackground = Color(0xFFFFFFFF); // White

  // ---------------- DARK THEME ----------------
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkSecondary,
        tertiary: darkTertiary,
        surface: darkSurface,
        background: darkBackground,
        error: Color(0xFFCF6679),
        onPrimary: Color(0xFF0F0F1E),
        onSecondary: Color(0xFFFFFFFF),
        onSurface: Color(0xFFFFFFFF),
        onBackground: Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: darkBackground,

      textTheme: ThemeData.dark().textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: darkPrimary,
        ),
        displayMedium: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: darkPrimary,
        ),
        displaySmall: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: darkPrimary,
        ),
        headlineLarge: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headlineSmall: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: Colors.white70,
        ),
        bodySmall: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          color: Colors.white60,
        ),
      ),

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
        iconTheme: IconThemeData(color: darkPrimary),
      ),

      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 8,
        shadowColor: darkPrimary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: darkPrimary,
            width: 1.5,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: darkBackground,
          elevation: 8,
          shadowColor: darkPrimary.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimary,
          side: const BorderSide(color: darkPrimary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      iconTheme: const IconThemeData(
        color: darkPrimary,
        size: 24,
      ),
    );
  }

  // ---------------- LIGHT THEME ----------------
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightSecondary,
        tertiary: lightTertiary,
        surface: lightSurface,
        background: lightBackground,
        error: Color(0xFFB00020),
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Color(0xFFFFFFFF),
        onSurface: Color(0xFF1C1B1F),
        onBackground: Color(0xFF1C1B1F),
      ),
      scaffoldBackgroundColor: lightBackground,

      textTheme: ThemeData.light().textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
        displayMedium: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
        displaySmall: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: lightPrimary,
        ),
        headlineLarge: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1C1B1F),
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1C1B1F),
        ),
        headlineSmall: const TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1C1B1F),
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Color(0xFF1C1B1F),
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: Color(0xFF49454F),
        ),
        bodySmall: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          color: Color(0xFF79747E),
        ),
      ),

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
        iconTheme: IconThemeData(color: lightPrimary),
      ),

      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 4,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: lightPrimary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: lightPrimary.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightPrimary,
          side: const BorderSide(color: lightPrimary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      iconTheme: const IconThemeData(
        color: lightPrimary,
        size: 24,
      ),
    );
  }
}
