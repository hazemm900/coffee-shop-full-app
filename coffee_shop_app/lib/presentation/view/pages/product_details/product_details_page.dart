import 'package:coffee_shop_app/presentation/view/pages/product_details/widgets/add_to_cart_button.dart';
import 'package:coffee_shop_app/presentation/view/pages/product_details/widgets/product_description_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/product_details/widgets/product_header_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/product_details/widgets/product_image_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/product_details/widgets/product_ingredients_section.dart';
import 'package:flutter/material.dart';
import 'package:shared_data/entities/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageSection(imageUrl: product.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductHeaderSection(product: product),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  ProductDescriptionSection(description: product.description),
                  const SizedBox(height: 16),
                  if (product.ingredients.isNotEmpty)
                    ProductIngredientsSection(ingredients: product.ingredients),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddToCartButton(product: product),
    );
  }
}
