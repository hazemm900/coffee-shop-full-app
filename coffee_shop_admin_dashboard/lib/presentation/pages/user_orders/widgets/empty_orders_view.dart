import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class EmptyOrdersView extends StatelessWidget {
  const EmptyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.coffee, size: 80, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'No Orders Found ☕',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This user hasn’t placed any orders yet.',
            style: TextStyle(color: AppColors.secondary),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }
}
