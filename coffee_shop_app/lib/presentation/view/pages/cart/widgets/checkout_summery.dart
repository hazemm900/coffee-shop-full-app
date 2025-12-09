import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/cart_item.dart';

class CheckoutSummary extends StatelessWidget {
  final CheckoutState checkoutState;
  final double finalPrice;
  final double totalPrice;
  final List<CartItem> items;

  const CheckoutSummary({
    required this.checkoutState,
    required this.finalPrice,
    required this.totalPrice,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (checkoutState.discountAmount > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discount:',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
              Text(
                '-${checkoutState.discountAmount.toStringAsFixed(2)} EGP',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${finalPrice.toStringAsFixed(2)} EGP',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            checkoutState.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: checkoutState.pointsError != null
                        ? null
                        : () {
                            context.read<CheckoutViewModel>().confirmOrder(
                              items,
                              totalPrice,
                            );
                          },
                    child: const Text('Place Order'),
                  ),
          ],
        ),
      ],
    );
  }
}
