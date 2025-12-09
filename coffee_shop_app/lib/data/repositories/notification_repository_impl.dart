import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:coffee_shop_app/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:shared_data/entities/notification.dart';
import 'package:shared_data/models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirestoreDataSource dataSource;
  final firebase.FirebaseAuth firebaseAuth;

  NotificationRepositoryImpl({
    required this.dataSource,
    required this.firebaseAuth,
  });

  @override
  Stream<Either<Failure, List<AppNotification>>> getNotificationsStream() {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      // أرجع Stream يحتوي على خطأ واحد
      return Stream.value(Left(ServerFailure("User not logged in")));
    }
    return dataSource.getNotificationsStream(currentUser.uid).map((snapshot) {
      try {
        final notifications = snapshot.docs
            .map((doc) => AppNotificationModel.fromSnapshot(doc))
            .toList();
        return Right(notifications);
      } catch (e) {
        return Left(ServerFailure("Failed to parse notifications."));
      }
    });
  }
}
