import 'package:flutter/material.dart';
import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';

class DashboardAppBar extends StatelessWidget {
  final String title;
  const DashboardAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.secondary.withOpacity(0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: AppColors.primary),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: AppColors.primary),
                onPressed: () {
                  // TODO: Logout logic
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
