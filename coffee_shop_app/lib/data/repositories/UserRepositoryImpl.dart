import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirestoreDataSource firestoreDataSource;
  final firebase.FirebaseAuth firebaseAuth;

  UserRepositoryImpl({
    required this.firestoreDataSource,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Left(ServerFailure("User is not logged in."));
    }

    try {
      final userModel = await firestoreDataSource.getUserProfile(
        currentUser.uid,
      );
      return Right(userModel as User);
    } catch (e) {
      return Left(
        ServerFailure("Failed to fetch user profile: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, void>> awardPoints(double orderTotal) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Left(ServerFailure("User is not logged in."));
    }
    try {
      // تطبيق قاعدة العمل: نقطة لكل 10 جنيهات
      final int pointsToAdd = (orderTotal / 10).floor();
      if (pointsToAdd > 0) {
        await firestoreDataSource.awardPoints(currentUser.uid, pointsToAdd);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to award points: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> redeemPoints(int points) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Left(ServerFailure("User is not logged in."));
    }
    try {
      await firestoreDataSource.redeemPoints(currentUser.uid, points);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // إرجاع رسالة الخطأ الفعلية
    }
  }

  @override
  Future<Either<Failure, void>> saveFCMToken(String token) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Left(ServerFailure("User is not logged in."));
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'fcmToken': token});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("Failed to save FCM token: ${e.toString()}"));
    }
  }
}
