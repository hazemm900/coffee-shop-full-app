import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/product_action_buttons.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/product_form_card.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/product_form_fields.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/product_switches_row.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/add_edit_product_state.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/add_edit_product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';

class AddEditProductPage extends StatelessWidget {
  final Product? product;
  const AddEditProductPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final isEditing = product != null;

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product?.name ?? '');
    final descriptionController = TextEditingController(
      text: product?.description ?? '',
    );
    final priceController = TextEditingController(
      text: product?.price.toString() ?? '',
    );
    final offerPriceController = TextEditingController(
      text: product?.offerPrice.toString() ?? '',
    );
    final categoryController = TextEditingController(
      text: product?.category ?? '',
    );
    final imageUrlController = TextEditingController(
      text: product?.imageUrl ?? '',
    );

    bool isAvailable = product?.isAvailable ?? true;
    bool isFeatured = product?.isFeatured ?? false;

    void onSave(BuildContext context) {
      if (formKey.currentState!.validate()) {
        final newProduct = Product(
          id: product?.id ?? '',
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          price: double.parse(priceController.text.trim()),
          offerPrice: double.parse(offerPriceController.text.trim()),
          category: categoryController.text.trim(),
          imageUrl: imageUrlController.text.trim(),
          ingredients: const [],
          isAvailable: isAvailable,
          isFeatured: isFeatured,
        );

        context.read<AddEditProductViewModel>().saveProduct(
          newProduct,
          isEditing,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Product' : 'Add Product'),
        centerTitle: true,
      ),
      body: BlocConsumer<AddEditProductViewModel, AddEditProductState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing
                      ? 'Product updated successfully!'
                      : 'Product added successfully!',
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop(true);
          } else if (state.status == FormStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to save product'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: SingleChildScrollView(
              child: Animate(
                effects: [
                  FadeEffect(duration: 400.ms),
                  SlideEffect(begin: const Offset(0, 0.2), end: Offset.zero),
                ],
                child: ProductFormCard(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProductFormFields(
                          nameController: nameController,
                          descriptionController: descriptionController,
                          priceController: priceController,
                          offerPriceController: offerPriceController,
                          categoryController: categoryController,
                          imageUrlController: imageUrlController,
                        ),
                        const SizedBox(height: 20),
                        ProductSwitchesRow(
                          isAvailable: isAvailable,
                          isFeatured: isFeatured,
                          onAvailableChanged: (val) => isAvailable = val,
                          onFeaturedChanged: (val) => isFeatured = val,
                        ),
                        const SizedBox(height: 24),
                        ProductActionButtons(
                          isEditing: isEditing,
                          onCancel: () => Navigator.pop(context),
                          onSave: () => onSave(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
