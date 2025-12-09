import 'package:coffee_shop_admin_dashboard/domain/usecases/get_user_orders_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_data/models/order_model.dart';

class UserOrdersViewModel extends ChangeNotifier {
  final GetUserOrdersUsecase getUserOrdersUsecase;
  final String userId;

  UserOrdersViewModel(this.getUserOrdersUsecase, this.userId);

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchUserOrders() async {
    _isLoading = true;
    notifyListeners();

    final result = await getUserOrdersUsecase.execute(userId);
    result.fold(
      (failure) => _error = failure.message,
      (data) => _orders = data,
    );

    _isLoading = false;
    notifyListeners();
  }
}
