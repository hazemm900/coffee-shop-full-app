import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, void>> sendNotificationToAll({
    required String title,
    required String body,
  });
}
