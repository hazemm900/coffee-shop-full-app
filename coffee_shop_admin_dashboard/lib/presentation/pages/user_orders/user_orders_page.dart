import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/user_orders_viewmodel/user_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_data/entities/user.dart';
import '../../../../core/service_locator.dart';
import '../../../../core/theme/app_theme.dart';
import 'widgets/user_orders_body.dart';

class UserOrdersPage extends StatelessWidget {
  final User user;

  const UserOrdersPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = UserOrdersViewModel(sl(), user.id);
        vm.fetchUserOrders();
        return vm;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.backgroundLight,
          centerTitle: true,
          title: Text(
            "${user.name}'s Orders",
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: const UserOrdersBody(),
      ),
    );
  }
}
