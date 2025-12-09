import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/models/order_model.dart';

class GetUserOrdersUsecase {
  final OrderRepository repository;

  GetUserOrdersUsecase(this.repository);

  Future<Either<Failure, List<OrderModel>>> execute(String uid) {
    return repository.getUserOrders(uid);
  }
}
