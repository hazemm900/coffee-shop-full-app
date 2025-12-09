import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OrderHeader extends StatelessWidget {
  final dynamic order;
  final String date;

  const OrderHeader({super.key, required this.order, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order #${order.id.substring(0, 6)}',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              '${order.totalPrice.toStringAsFixed(2)} EGP',
              style: const TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          date,
          style: const TextStyle(color: AppColors.secondary, fontSize: 13),
        ),
        const Divider(height: 20),
      ],
    );
  }
}
