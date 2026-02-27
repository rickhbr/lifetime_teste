import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const gold = Color(0xFFF59E0B);
  static const goldLight = Color(0xFFFBBF24);
  static const scaffoldBg = Color(0xFF0A0E17);
  static const surfaceDark = Color(0xFF111827);
  static const surfaceLight = Color(0xFF1F2937);
  static const greenBuy = Color(0xFF10B981);
  static const redSell = Color(0xFFEF4444);
  static const textPrimary = Color(0xFFF9FAFB);
  static const textSecondary = Color(0xFF9CA3AF);
  static const border = Color(0xFF1F2937);

  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      brightness: Brightness.dark,
      primary: gold,
      onPrimary: scaffoldBg,
      surface: surfaceDark,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      error: redSell,
      onError: textPrimary,
      errorContainer: Color(0xFF3B1111),
      onErrorContainer: redSell,
      outline: border,
      outlineVariant: border,
      surfaceContainerHighest: surfaceLight,
      surfaceContainerLowest: surfaceLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
      // Typography
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: textPrimary,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: textPrimary,
        ),
      ),
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: redSell),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: redSell, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textSecondary),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: border),
        ),
        color: surfaceDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: gold,
          foregroundColor: scaffoldBg,
          disabledBackgroundColor: gold.withValues(alpha: 0.3),
          disabledForegroundColor: scaffoldBg.withValues(alpha: 0.5),
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: textPrimary,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: border),
        ),
      ),
      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
