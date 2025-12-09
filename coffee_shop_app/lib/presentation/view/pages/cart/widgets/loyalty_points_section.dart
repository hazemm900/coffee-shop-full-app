import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoyaltyPointsSection extends StatelessWidget {
  final int userPoints;
  final CheckoutState checkoutState;
  final double totalPrice;

  const LoyaltyPointsSection({
    required this.userPoints,
    required this.checkoutState,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You have $userPoints Loyalty Points',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Points to Redeem',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            errorText: checkoutState.pointsError,
          ),
          onChanged: (value) {
            final points = int.tryParse(value) ?? 0;
            context.read<CheckoutViewModel>().applyPoints(
              points,
              userPoints,
              totalPrice,
            );
          },
        ),
      ],
    );
  }
}
