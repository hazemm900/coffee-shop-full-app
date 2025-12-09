import 'package:coffee_shop_admin_dashboard/core/helper/custom_cached_network_image.dart';
import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/pages/poducts/widgets/product_action.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isVisible = true;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: _isVisible ? 1.0 : 0.95,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🖼 صورة المنتج
              AspectRatio(
                aspectRatio: 1.5, // ⬆️ تحكم في ارتفاع الصورة بالنسبة للعرض
                child: widget.product.imageUrl != null
                    ? CustomNetworkImage(
                        image: widget.product.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Container(
                        color: AppColors.backgroundLight,
                        child: const Center(
                          child: Icon(
                            Icons.coffee,
                            size: 70,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              ),

              /// 📋 معلومات المنتج
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product.category,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    /// 💰 السعر والعرض
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.product.price} EGP',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        if (widget.product.isOnOffer)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${widget.product.offerPrice} EGP',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// ✅ الحالة (متاح / غير متاح)
                    Row(
                      children: [
                        Icon(
                          widget.product.isAvailable
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: widget.product.isAvailable
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.product.isAvailable
                              ? 'Available'
                              : 'Not Available',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    /// ⚙️ الأكشنز
                    _isDeleting
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : ProductActions(
                            product: widget.product,
                            onDelete: _handleDelete,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, Product product) async {
    final confirmed = await _showDeleteDialog(context, product);
    if (confirmed != true) return;

    final productsViewModel = context.read<ProductsViewModel>();
    setState(() => _isDeleting = true);
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => _isVisible = false);
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      await productsViewModel.removeProduct(product.id);
    }
  }

  Future<bool?> _showDeleteDialog(BuildContext context, Product product) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
