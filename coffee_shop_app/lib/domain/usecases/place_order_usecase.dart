import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/order.dart';
import '../../core/error/failures.dart';
import '../repositories/checkout_repository.dart';

class PlaceOrderUsecase {
  final CheckoutRepository repository;
  PlaceOrderUsecase(this.repository);

  Future<Either<Failure, void>> execute(OrderDetails orderDetails) {
    return repository.placeOrder(orderDetails);
  }
}
