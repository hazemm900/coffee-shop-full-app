import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop_admin_dashboard/core/service_locator.dart';
import 'package:coffee_shop_admin_dashboard/core/theme/app_theme.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/promotions_viewmodel/promotions_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/promotions_viewmodel/promotions_state.dart';
import 'widgets/promotions_header.dart';
import 'widgets/promotions_table.dart';
import 'widgets/loading_view.dart';
import 'widgets/empty_promotions_view.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PromotionsViewModel>()..fetchPromotions(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PromotionsHeader(),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<PromotionsViewModel, PromotionsState>(
                    builder: (context, state) {
                      if (state.status == ViewStatus.loading) {
                        return const LoadingView();
                      }

                      if (state.promotions.isEmpty) {
                        return const EmptyPromotionsView();
                      }

                      return PromotionsTable(promotions: state.promotions);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
