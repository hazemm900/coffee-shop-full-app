import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirestoreDataSource firestoreDataSource;
  final firebase.FirebaseAuth firebaseAuth;

  OrderRepositoryImpl({
    required this.firestoreDataSource,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, List<OrderDetails>>> getMyOrders() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Left(ServerFailure("User is not logged in."));
    }

    try {
      final orderModels = await firestoreDataSource.getMyOrders(
        currentUser.uid,
      );
      return Right(orderModels.cast<OrderDetails>());
    } catch (e) {
      return Left(ServerFailure("Failed to fetch orders: ${e.toString()}"));
    }
  }
}
