import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;
  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.shopping_cart_checkout_rounded),
        label: const Text('Add to Cart'),
        onPressed: !product.isAvailable
            ? null
            : () {
                context.read<CartViewModel>().addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${product.name} has been added to your cart!',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ).animate().slideY(begin: 1, end: 0).fadeIn(duration: 500.ms),
    );
  }
}
