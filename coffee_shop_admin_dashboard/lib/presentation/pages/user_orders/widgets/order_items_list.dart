import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OrderItemsList extends StatelessWidget {
  final dynamic order;

  const OrderItemsList({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...order.items.map<Widget>((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${item.quantity} × ${item.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        if (order.discountAmount > 0)
          Text(
            'Discount Applied: ${order.discountAmount.toStringAsFixed(2)} EGP',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (order.pointsRedeemed > 0)
          Text(
            'Points Redeemed: ${order.pointsRedeemed}',
            style: const TextStyle(color: AppColors.secondary, fontSize: 13),
          ),
      ],
    );
  }
}
