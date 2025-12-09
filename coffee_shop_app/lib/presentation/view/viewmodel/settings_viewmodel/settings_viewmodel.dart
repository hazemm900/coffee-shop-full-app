// lib/presentation/viewmodel/settings_viewmodel.dart
import 'package:coffee_shop_app/domain/usecases/get_theme_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/save_theme_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsViewModel extends Cubit<SettingsState> {
  final GetThemeUsecase getThemeUsecase;
  final SaveThemeUsecase saveThemeUsecase;

  SettingsViewModel(this.getThemeUsecase, this.saveThemeUsecase)
    : super(const SettingsState()) {
    _loadTheme(); // تحميل الثيم المحفوظ عند البدء
  }

  Future<void> _loadTheme() async {
    final themeMode = await getThemeUsecase.execute();
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    final newThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // 1. احفظ الثيم الجديد في الذاكرة المحلية
    await saveThemeUsecase.execute(newThemeMode);
    // 2. حدّث حالة التطبيق
    emit(state.copyWith(themeMode: newThemeMode));
  }
}
