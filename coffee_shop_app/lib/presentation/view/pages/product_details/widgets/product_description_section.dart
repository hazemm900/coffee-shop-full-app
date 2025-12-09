import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String description;
  const ProductDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ).animate().fadeIn(duration: 600.ms),
      ],
    );
  }
}
