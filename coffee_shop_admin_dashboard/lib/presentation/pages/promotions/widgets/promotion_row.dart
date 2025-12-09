import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/service_locator.dart';
import '../../../viewmodel/promotions_viewmodel/add_edit_promotion_viewmodel.dart';
import '../../../viewmodel/promotions_viewmodel/promotions_viewmodel.dart';
import '../add_edit_promotion_page.dart';

DataRow buildPromotionRow(BuildContext context, Promotion promo) {
  final f = DateFormat('dd/MM/yyyy');
  return DataRow(
    cells: [
      DataCell(Text(promo.title)),
      DataCell(Text(promo.type.name)),
      DataCell(Text(promo.promoCode ?? 'N/A')),
      DataCell(
        Text(
          promo.discountType == DiscountType.PERCENTAGE
              ? '${promo.discountValue}%'
              : '${promo.discountValue} EGP',
        ),
      ),
      DataCell(
        Text(
          promo.status.name,
          style: TextStyle(
            color: promo.status == PromotionStatus.ACTIVE
                ? Colors.green
                : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      DataCell(
        Text(promo.endDate != null ? f.format(promo.endDate!) : 'Never'),
      ),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.primary),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => sl<AddEditPromotionViewModel>(),
                      child: AddEditPromotionPage(promotion: promo),
                    ),
                  ),
                );
                if (result == true) {
                  context.read<PromotionsViewModel>().fetchPromotions();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text(
                      'Delete Promotion',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to delete this promotion?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<PromotionsViewModel>().deletePromotion(
                            promo.id!,
                          );
                          Navigator.pop(ctx);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
