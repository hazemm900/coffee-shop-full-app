import 'package:coffee_shop_app/data/datasourses/theme_local_datasource.dart';
import 'package:coffee_shop_app/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;
  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<ThemeMode> getTheme() async {
    final themeName = await localDataSource.getCachedTheme();
    if (themeName == 'dark') return ThemeMode.dark;
    if (themeName == 'light') return ThemeMode.light;
    return ThemeMode.system; // القيمة الافتراضية
  }

  @override
  Future<void> saveTheme(ThemeMode themeMode) {
    String themeName = 'system';
    if (themeMode == ThemeMode.dark) themeName = 'dark';
    if (themeMode == ThemeMode.light) themeName = 'light';
    return localDataSource.cacheTheme(themeName);
  }
}
