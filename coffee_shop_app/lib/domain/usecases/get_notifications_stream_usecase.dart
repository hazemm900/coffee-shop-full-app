import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/notification.dart';
import '../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsStreamUsecase {
  final NotificationRepository repository;
  GetNotificationsStreamUsecase(this.repository);
  Stream<Either<Failure, List<AppNotification>>> execute() =>
      repository.getNotificationsStream();
}
