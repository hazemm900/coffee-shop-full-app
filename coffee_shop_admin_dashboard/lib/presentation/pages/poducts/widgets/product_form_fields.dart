import 'package:flutter/material.dart';
import 'product_text_field.dart';

class ProductFormFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController offerPriceController;
  final TextEditingController categoryController;
  final TextEditingController imageUrlController;

  const ProductFormFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    required this.offerPriceController,
    required this.categoryController,
    required this.imageUrlController,
  });

  @override
  State<ProductFormFields> createState() => _ProductFormFieldsState();
}

class _ProductFormFieldsState extends State<ProductFormFields> {
  final List<String> categories = [
    'General',
    'Ice Drinks',
    'Hot Drinks',
    'Bakery',
    'Salads',
    '➕ Add new category manually',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductTextField(
          controller: widget.nameController,
          label: 'Product Name',
        ),
        ProductTextField(
          controller: widget.descriptionController,
          label: 'Description',
          maxLines: 3,
        ),
        ProductTextField(
          controller: widget.priceController,
          label: 'Price',
          isNumber: true,
        ),
        ProductTextField(
          controller: widget.offerPriceController,
          label: 'Offer Price',
          isNumber: true,
        ),

        // 👇 Dropdown مع خيار إضافة كاتيجوري جديدة
        DropdownButtonFormField<String>(
          value: categories.contains(widget.categoryController.text)
              ? widget.categoryController.text
              : null,
          decoration: InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          items: categories
              .map(
                (category) =>
                    DropdownMenuItem(value: category, child: Text(category)),
              )
              .toList(),
          onChanged: (value) async {
            if (value == null) return;

            if (value == '➕ Add new category manually') {
              final newCategory = await _showAddCategoryDialog(context);
              if (newCategory != null && newCategory.trim().isNotEmpty) {
                final exists = categories.any(
                  (c) => c.toLowerCase() == newCategory.toLowerCase(),
                );
                if (exists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This category already exists!'),
                      backgroundColor: Colors.orangeAccent,
                    ),
                  );
                  return;
                }

                setState(() {
                  categories.insert(categories.length - 1, newCategory);
                  widget.categoryController.text = newCategory;
                });
              }
            } else {
              widget.categoryController.text = value;
            }
          },
          validator: (value) => value == null || value.isEmpty
              ? 'Please select a category'
              : null,
        ),

        const SizedBox(height: 16),
        ProductTextField(
          controller: widget.imageUrlController,
          label: 'Image URL',
        ),
      ],
    );
  }

  /// 📦 Dialog لإضافة كاتيجوري جديدة
  Future<String?> _showAddCategoryDialog(BuildContext context) async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Category'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Category Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;
              Navigator.pop(context, text);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
