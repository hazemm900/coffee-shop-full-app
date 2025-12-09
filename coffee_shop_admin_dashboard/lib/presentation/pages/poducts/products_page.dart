import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/add_edit_product_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/products_grid.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/add_edit_product_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: AppColors.primary),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => sl<AddEditProductViewModel>(),
                      child: const AddEditProductPage(),
                    ),
                  ),
                );
                if (result == true) {
                  context.read<ProductsViewModel>().fetchProducts();
                }
              },
            ),
          ],
        ),
        body: const ProductsGrid(),
      ),
    );
  }
}
