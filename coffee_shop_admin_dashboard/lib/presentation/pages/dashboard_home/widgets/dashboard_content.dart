import 'package:flutter/material.dart';
import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';

class DashboardContent extends StatelessWidget {
  final Widget page;
  const DashboardContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(color: Colors.white, child: page),
        ),
      ),
    );
  }
}
