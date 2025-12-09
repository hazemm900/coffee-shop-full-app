import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, void>> updateUserRole(String uid, String newRole);
  Future<Either<Failure, void>> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String? phoneNumber,
    required String? gender,
    required DateTime? birthDate,
    required String? fcmToken,
  });
  Future<Either<Failure, void>> deleteUser(String userId);
}
