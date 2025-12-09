import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductIngredientsSection extends StatelessWidget {
  final List<String> ingredients;
  const ProductIngredientsSection({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: ingredients
              .map(
                (ingredient) => Chip(
                  label: Text(ingredient),
                  backgroundColor: theme.colorScheme.surface,
                ),
              )
              .toList(),
        ).animate().fadeIn(duration: 700.ms),
      ],
    );
  }
}
