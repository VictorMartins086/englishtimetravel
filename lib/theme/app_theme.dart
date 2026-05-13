import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0A0420);
  static const Color backgroundDeep = Color(0xFF050118);
  static const Color surface = Color(0xFF15082E);
  static const Color surfaceAlt = Color(0xFF1C0B3A);
  static const Color border = Color(0xFF2A1456);
  static const Color primary = Color(0xFF9B6BFF);
  static const Color primaryDark = Color(0xFF6E3DE8);
  static const Color accent = Color(0xFFC9A4FF);
  static const Color gold = Color(0xFFE2B255);
  static const Color goldLight = Color(0xFFF6D27B);
  static const Color gem = Color(0xFFB14CFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB9A8E0);
  static const Color textMuted = Color(0xFF7E6CA8);
}

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = base.textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
      fontFamily: 'Roboto',
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    );
  }
}
