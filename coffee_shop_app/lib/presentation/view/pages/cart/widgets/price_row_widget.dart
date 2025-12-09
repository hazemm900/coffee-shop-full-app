import 'package:flutter/material.dart';

/// 💸 Small widget for showing price rows.
class PriceRowWidget extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;
  final double size;
  final Color? color;

  const PriceRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.size = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            '${value >= 0 ? '' : '-'}${value.abs().toStringAsFixed(2)} EGP',
            style: TextStyle(
              fontSize: size,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
