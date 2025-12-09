import 'package:coffee_shop_app/domain/usecases/get_my_orders_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/order.dart';

part 'my_orders_state.dart';

class MyOrdersViewModel extends Cubit<MyOrdersState> {
  final GetMyOrdersUsecase getMyOrdersUsecase;

  MyOrdersViewModel(this.getMyOrdersUsecase) : super(MyOrdersInitial()) {
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    emit(MyOrdersLoading());
    final result = await getMyOrdersUsecase.execute();
    result.fold(
      (failure) => emit(MyOrdersError(failure.message)),
      (orders) => emit(MyOrdersLoaded(orders)),
    );
  }
}
