import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/cart_item_list.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/checkout_summery.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/loyalty_points_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/order_success_page.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/profile_viewmodel/profile_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_data/entities/cart_item.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.read<CartViewModel>().state;
    final items = (cartState is CartLoaded) ? cartState.items : <CartItem>[];
    final totalPrice = (cartState is CartLoaded) ? cartState.finalTotal : 0.0;

    final profileState = context.watch<ProfileViewModel>().state;
    final userPoints = (profileState is ProfileLoaded)
        ? profileState.user.loyaltyPoints
        : 0;

    return BlocProvider(
      create: (_) => sl<CheckoutViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Checkout',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<CheckoutViewModel, CheckoutState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const OrderSuccessPage()),
              );
            } else if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<CheckoutViewModel, CheckoutState>(
            builder: (context, checkoutState) {
              final finalPrice = totalPrice - checkoutState.discountAmount;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // 🧾 قائمة العناصر
                    CartItemsList(items: items)
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 20),

                    // 💎 نقاط الولاء
                    LoyaltyPointsSection(
                          userPoints: userPoints,
                          checkoutState: checkoutState,
                          totalPrice: totalPrice,
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideX(begin: -0.2, end: 0),

                    const SizedBox(height: 20),

                    // 💰 الإجمالي والزر
                    CheckoutSummary(
                          checkoutState: checkoutState,
                          finalPrice: finalPrice,
                          totalPrice: totalPrice,
                          items: items,
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.3, end: 0),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
