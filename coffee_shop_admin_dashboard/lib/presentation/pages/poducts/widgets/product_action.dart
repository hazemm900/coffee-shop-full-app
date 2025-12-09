import 'package:coffee_shop_admin_dashboard/core/service_locator.dart';
import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/add_edit_product_page.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/add_edit_product_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';

class ProductActions extends StatelessWidget {
  final Product product;
  final Future<void> Function(BuildContext, Product)? onDelete;
  const ProductActions({super.key, required this.product, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: AppColors.primary),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => sl<AddEditProductViewModel>(),
                  child: AddEditProductPage(product: product),
                ),
              ),
            );
            if (result == true) {
              context.read<ProductsViewModel>().fetchProducts();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete?.call(context, product),
        ),
      ],
    );
  }
}
