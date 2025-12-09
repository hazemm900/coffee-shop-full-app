import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/service_locator.dart';
import '../../../viewmodel/promotions_viewmodel/promotions_viewmodel.dart';
import '../../../viewmodel/promotions_viewmodel/add_edit_promotion_viewmodel.dart';
import '../add_edit_promotion_page.dart';

class PromotionsHeader extends StatelessWidget {
  const PromotionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        ElevatedButton.icon(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => sl<AddEditPromotionViewModel>(),
                  child: const AddEditPromotionPage(),
                ),
              ),
            );
            if (result == true) {
              context.read<PromotionsViewModel>().fetchPromotions();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "Add Promotion",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
