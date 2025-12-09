import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/pages/my_orders/widgets/orders_card.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/my_orders_viemodel/my_orders_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MyOrdersViewModel>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'My Orders',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: BlocBuilder<MyOrdersViewModel, MyOrdersState>(
          builder: (context, state) {
            if (state is MyOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MyOrdersError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is MyOrdersLoaded) {
              if (state.orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.coffee, size: 80, color: AppColors.primary),
                      const SizedBox(height: 16),
                      Text(
                        'No Orders Yet ☕',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start your first coffee order now!',
                        style: TextStyle(color: AppColors.secondary),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return OrderCardWidget(order: order);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
