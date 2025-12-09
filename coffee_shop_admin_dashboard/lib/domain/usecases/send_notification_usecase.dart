import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/notification_repository.dart';

class SendNotificationUsecase {
  final NotificationRepository repository;
  SendNotificationUsecase(this.repository);

  Future<Either<Failure, void>> execute({
    required String title,
    required String body,
  }) {
    return repository.sendNotificationToAll(title: title, body: body);
  }
}
