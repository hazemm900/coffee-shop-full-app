import 'package:flutter/material.dart';

class ProductFormCard extends StatelessWidget {
  final Widget child;
  const ProductFormCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(padding: const EdgeInsets.all(24.0), child: child),
    );
  }
}
