import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_data/entities/product.dart';

class ProductHeaderSection extends StatelessWidget {
  final Product product;
  const ProductHeaderSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.category,
          style: TextStyle(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ).animate().slideX(begin: -0.2, end: 0),

        const SizedBox(height: 8),

        Text(
          product.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ).animate().slideX(begin: 0.2, end: 0),

        const SizedBox(height: 16),

        Row(
          children: [
            if (product.isOnOffer) ...[
              Text(
                '${product.offerPrice} EGP',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${product.price} EGP',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ] else ...[
              Text(
                '${product.price} EGP',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ).animate().fadeIn(duration: 500.ms),
      ],
    );
  }
}
