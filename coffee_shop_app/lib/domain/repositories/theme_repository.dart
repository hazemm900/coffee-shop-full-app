import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<void> saveTheme(ThemeMode themeMode);
  Future<ThemeMode> getTheme();
}
