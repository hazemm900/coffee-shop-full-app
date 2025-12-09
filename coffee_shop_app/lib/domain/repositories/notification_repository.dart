import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/notification.dart';

import '../../core/error/failures.dart';

abstract class NotificationRepository {
  Stream<Either<Failure, List<AppNotification>>> getNotificationsStream();
}
