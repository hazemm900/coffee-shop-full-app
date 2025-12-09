import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/models/order_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getUserOrders(String uid);
}
