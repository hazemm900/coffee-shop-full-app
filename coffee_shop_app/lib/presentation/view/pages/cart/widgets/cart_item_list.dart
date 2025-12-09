import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_data/entities/cart_item.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItem> items;
  const CartItemsList({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Your cart is empty.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Items',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.product.imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.product.name),
                subtitle: Text('x${item.quantity}'),
                trailing: Text(
                  '${(item.product.price * item.quantity).toStringAsFixed(2)} EGP',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.2, end: 0);
          },
        ),
      ],
    );
  }
}
