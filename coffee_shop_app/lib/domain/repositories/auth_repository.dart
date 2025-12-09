import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required DateTime birthDate,
  });
  Future<Either<Failure, void>> logout();
}
