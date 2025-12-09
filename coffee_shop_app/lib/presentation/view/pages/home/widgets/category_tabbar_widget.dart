/* -----------------------------------------------------
   🏷️ CategoryTabBarWidget
   - Styled TabBar (uses AppColors)
   - Animated entrance for smoother UX
   ----------------------------------------------------- */
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabBarWidget extends StatelessWidget {
  const CategoryTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeViewModel>().state;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(state.categories.length),
        color: AppColors.backgroundLight,
        alignment: Alignment.center,
        child: TabBar(
          isScrollable: true,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
          tabs: state.categories.map((cat) => Tab(text: cat)).toList(),
          onTap: (index) {
            context.read<HomeViewModel>().onCategorySelected(
              state.categories[index],
            );
          },
        ),
      ),
    );
  }
}
