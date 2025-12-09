import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/order.dart';
import 'package:shared_data/models/order_model.dart';
import '../../domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final FirestoreDataSource dataSource;
  CheckoutRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> placeOrder(OrderDetails orderDetails) async {
    try {
      final orderModel = OrderModel(
        items: orderDetails.items,
        totalPrice: orderDetails.totalPrice,
        userId: orderDetails.userId,
        timestamp: orderDetails.timestamp,
        pointsRedeemed: orderDetails.pointsRedeemed, // ✅
        discountAmount: orderDetails.discountAmount, // ✅

        id: '',
      );
      await dataSource.createOrder(orderModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Failed to place order."));
    }
  }
}
