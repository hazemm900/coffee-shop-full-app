import 'package:coffee_shop_app/core/helper/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductImageSection extends StatelessWidget {
  final String imageUrl;
  const ProductImageSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CustomNetworkImage(
          image: imageUrl,
          width: double.infinity,
          height: 350,
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}
