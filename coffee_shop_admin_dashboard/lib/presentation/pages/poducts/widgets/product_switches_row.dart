import 'package:flutter/material.dart';
import 'switch_tile.dart';

class ProductSwitchesRow extends StatelessWidget {
  final bool isAvailable;
  final bool isFeatured;
  final Function(bool) onAvailableChanged;
  final Function(bool) onFeaturedChanged;

  const ProductSwitchesRow({
    super.key,
    required this.isAvailable,
    required this.isFeatured,
    required this.onAvailableChanged,
    required this.onFeaturedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SwitchTile(
            title: 'Available',
            value: isAvailable,
            onChanged: onAvailableChanged,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SwitchTile(
            title: 'Featured',
            value: isFeatured,
            onChanged: onFeaturedChanged,
          ),
        ),
      ],
    );
  }
}
