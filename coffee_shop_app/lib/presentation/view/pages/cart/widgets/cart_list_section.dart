import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_data/entities/cart_item.dart';

/// 🧾 Section displaying the list of items in the cart with animation.
class CartListSection extends StatelessWidget {
  final List<CartItem> items;
  final bool isDark;

  const CartListSection({super.key, required this.items, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];

        // 🎬 Add fade + slide animation for each item
        return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 350),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: CartItemCard(item: item, isDark: isDark),
        );
      },
    );
  }
}
