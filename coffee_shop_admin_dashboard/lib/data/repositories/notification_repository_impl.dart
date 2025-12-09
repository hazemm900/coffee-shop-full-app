import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/functions_datasource.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';
// ... other imports

class NotificationRepositoryImpl implements NotificationRepository {
  final FunctionsDataSource dataSource;
  NotificationRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> sendNotificationToAll({
    required String title,
    required String body,
  }) async {
    try {
      await dataSource.sendNotificationToAll(title: title, body: body);
      return const Right(null);
    } catch (e) {
      // يمكن أن يكون الخطأ بسبب عدم وجود الـ function أو مشكلة في الصلاحيات
      return Left(
        ServerFailure("Failed to send notification: ${e.toString()}"),
      );
    }
  }
}
