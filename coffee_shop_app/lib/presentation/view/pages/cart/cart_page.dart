import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/cart_list_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/cart/widgets/cart_summery_section.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 🛒 Main Cart Page — shows user cart items, promo code, and checkout button.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => sl<CartViewModel>()..loadCartItems(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'My Cart',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartViewModel, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartError) {
              return Center(child: Text(state.message));
            }

            if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(child: Text('Your cart is empty! 🛒'));
              }

              return Column(
                children: [
                  Expanded(
                    child: CartListSection(
                      items: state.items,
                      isDark: theme.brightness == Brightness.dark,
                    ),
                  ),
                  CartSummarySection(state: state),
                ],
              );
            }

            return const Center(child: Text('Loading your cart...'));
          },
        ),
      ),
    );
  }
}
