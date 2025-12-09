import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, void>> awardPoints(double orderTotal);
  Future<Either<Failure, void>> redeemPoints(int points);
  Future<Either<Failure, void>> saveFCMToken(String token);
}
