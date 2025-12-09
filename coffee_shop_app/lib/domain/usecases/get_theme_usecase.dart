import 'package:flutter/material.dart';
import '../repositories/theme_repository.dart';

class GetThemeUsecase {
  final ThemeRepository repository;
  GetThemeUsecase(this.repository);
  Future<ThemeMode> execute() => repository.getTheme();
}
