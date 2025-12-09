import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LoadingOrErrorView extends StatelessWidget {
  final bool isLoading;
  final String? error;

  const LoadingOrErrorView({super.key, required this.isLoading, this.error});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    return Center(
      child: Text('Error: $error', style: const TextStyle(color: Colors.red)),
    );
  }
}
