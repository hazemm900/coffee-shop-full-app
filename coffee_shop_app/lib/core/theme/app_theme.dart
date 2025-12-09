// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A2B2B); // بني غامق (لون القهوة)
  static const Color secondary = Color(0xFFC8A079); // بيج دافئ (لون اللاتيه)
  static const Color backgroundLight = Color(
    0xFFFAF6F2,
  ); // خلفية فاتحة (أبيض مائل للبيج)
  static const Color backgroundDark = Color(0xFF2D1E1E); // خلفية داكنة
  static const Color cardDark = Color(0xFF3E2C2C); // لون الكروت في الوضع الداكن
  static const Color accent = Color(0xFFE57734); // لون مميز (برتقالي دافئ)
}

// استكمالًا لملف lib/core/theme/app_theme.dart

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: 'Poppins', // يمكنك إضافة خط مخصص هنا
      // نظام الألوان الحديث
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
      ),

      // تخصيص الـ AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white, // لون الأيقونات والنص
        elevation: 1,
      ),

      // تخصيص الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),

      // تخصيص حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.primary),
      ),

      // تخصيص الـ BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),

      // تخصيص الكروت
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      fontFamily: 'Poppins',

      // نظام الألوان الحديث للوضع الداكن
      colorScheme: const ColorScheme.dark(
        primary: AppColors
            .secondary, // في الوضع الداكن، اللون الفاتح يصبح هو الأساسي
        secondary: AppColors.primary,
        surface: AppColors.cardDark,
        error: Colors.redAccent,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),

      // تخصيص الـ AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardDark,
        foregroundColor: Colors.white,
        elevation: 1,
      ),

      // تخصيص الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),

      // تخصيص حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.secondary),
      ),

      // تخصيص الـ BottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.accent,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.cardDark,
      ),

      // تخصيص الكروت
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: AppColors.cardDark,
      ),
    );
  }
}
