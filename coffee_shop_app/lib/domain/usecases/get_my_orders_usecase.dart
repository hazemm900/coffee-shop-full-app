import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/order.dart';
import '../../core/error/failures.dart';
import '../repositories/order_repository.dart';

class GetMyOrdersUsecase {
  final OrderRepository repository;

  GetMyOrdersUsecase(this.repository);

  Future<Either<Failure, List<OrderDetails>>> execute() {
    return repository.getMyOrders();
  }
}
