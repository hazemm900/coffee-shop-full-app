/* -----------------------------------------------------
   🧱 ProductsGrid
   - Uses AnimatedSwitcher for smooth product transitions
   ----------------------------------------------------- */
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeViewModel>().state;

    if (state.filteredProducts.isEmpty) {
      return const Center(child: Text('No products found.'));
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: GridView.builder(
        key: ValueKey(state.filteredProducts.length),
        padding: const EdgeInsets.symmetric(vertical: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: state.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = state.filteredProducts[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
