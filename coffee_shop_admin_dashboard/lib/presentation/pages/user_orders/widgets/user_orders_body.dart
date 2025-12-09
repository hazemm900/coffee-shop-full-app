import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/user_orders_viewmodel/user_orders_viewmodel.dart';
import 'admin_order_card.dart';
import 'empty_orders_view.dart';
import 'loading_or_error_view.dart';

class UserOrdersBody extends StatelessWidget {
  const UserOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserOrdersViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading || vm.error != null) {
          return LoadingOrErrorView(isLoading: vm.isLoading, error: vm.error);
        }

        if (vm.orders.isEmpty) {
          return const EmptyOrdersView();
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: vm.orders.length,
          itemBuilder: (context, index) {
            final order = vm.orders[index];
            return AdminOrderCard(
              order: order,
            ).animate().fade(duration: 300.ms).slideY(begin: 0.1);
          },
        );
      },
    );
  }
}
