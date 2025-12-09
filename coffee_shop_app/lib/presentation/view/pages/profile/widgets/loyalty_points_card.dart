import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// ⭐ LoyaltyPointsCard
/// - Animated loyalty card showing user’s coffee points.
class LoyaltyPointsCard extends StatelessWidget {
  final int points;
  const LoyaltyPointsCard({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.0),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) =>
          Transform.scale(scale: value, child: child),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              '$points Loyalty Points',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
