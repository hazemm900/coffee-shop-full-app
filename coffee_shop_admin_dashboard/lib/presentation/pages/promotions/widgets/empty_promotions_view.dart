import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class EmptyPromotionsView extends StatelessWidget {
  const EmptyPromotionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_offer_rounded, size: 90, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'No Promotions Found 🎯',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can add new promotions to engage customers.',
            style: TextStyle(color: AppColors.secondary),
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }
}
