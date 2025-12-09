import 'package:flutter/material.dart';
import '../repositories/theme_repository.dart';

class SaveThemeUsecase {
  final ThemeRepository repository;
  SaveThemeUsecase(this.repository);
  Future<void> execute(ThemeMode themeMode) => repository.saveTheme(themeMode);
}
