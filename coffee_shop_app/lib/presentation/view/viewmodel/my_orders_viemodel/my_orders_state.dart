part of 'my_orders_viewmodel.dart';

abstract class MyOrdersState extends Equatable {
  const MyOrdersState();
  @override
  List<Object> get props => [];
}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersLoaded extends MyOrdersState {
  final List<OrderDetails> orders;
  const MyOrdersLoaded(this.orders);
}

class MyOrdersError extends MyOrdersState {
  final String message;
  const MyOrdersError(this.message);
}
