import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/firestore_datasource.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirestoreDataSource firestoreDataSource;

  OrderRepositoryImpl(this.firestoreDataSource);

  @override
  Future<Either<Failure, List<OrderModel>>> getUserOrders(String uid) async {
    try {
      final orders = await firestoreDataSource.getUserOrders(uid);
      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
