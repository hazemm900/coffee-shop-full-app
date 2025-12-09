import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/order.dart';
import '../../core/error/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderDetails>>> getMyOrders();
}
