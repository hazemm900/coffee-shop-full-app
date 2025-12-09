import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// ⚙️ ProfileActionButtons
/// - Displays user actions like viewing orders, editing profile, logout, etc.
class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onOrdersPressed;
  const ProfileActionButtons({super.key, required this.onOrdersPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.history),
          label: const Text('My Orders'),
          onPressed: onOrdersPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
