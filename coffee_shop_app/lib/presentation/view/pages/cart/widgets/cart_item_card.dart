import 'package:coffee_shop_app/core/helper/custom_cached_network_image.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/cart_item.dart';

/// 🧃 Widget representing a single cart item with smooth animations.
class CartItemCard extends StatelessWidget {
  final CartItem item;
  final bool isDark;

  const CartItemCard({super.key, required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = item.product;
    final itemPrice = product.isOnOffer ? product.offerPrice : product.price;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.1, 0.2),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Container(
        key: ValueKey(item.product.id),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 🖼️ Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomNetworkImage(
                image: product.imageUrl,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(width: 12),

            /// 📄 Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${itemPrice.toStringAsFixed(2)} EGP',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            /// ➕ Controls + Delete
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (item.quantity > 1) {
                          context.read<CartViewModel>().updateQuantity(
                            product.id,
                            item.quantity - 1,
                          );
                        } else {
                          context.read<CartViewModel>().removeFromCart(
                            product.id,
                          );
                        }
                      },
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        context.read<CartViewModel>().updateQuantity(
                          product.id,
                          item.quantity + 1,
                        );
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.read<CartViewModel>().removeFromCart(product.id);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
