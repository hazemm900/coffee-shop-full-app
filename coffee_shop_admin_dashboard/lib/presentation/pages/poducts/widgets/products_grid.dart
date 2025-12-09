import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/product_card.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsViewModel, ProductsState>(
      builder: (context, state) {
        if (state.status == ViewStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == ViewStatus.error) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }

        final products = state.products;
        if (products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // تحديد عدد الأعمدة حسب عرض الشاشة
            int crossAxisCount = 4;
            if (constraints.maxWidth < 1200) crossAxisCount = 3;
            if (constraints.maxWidth < 900) crossAxisCount = 2;
            if (constraints.maxWidth < 600) crossAxisCount = 1;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]).animate().fadeIn(
                    duration: 400.ms,
                    curve: Curves.easeOut,
                    delay: (index * 70).ms,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
