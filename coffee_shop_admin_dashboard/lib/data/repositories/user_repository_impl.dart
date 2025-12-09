import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/firestore_datasource.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';

class UserRepositoryImpl implements UserRepository {
  final FirestoreDataSource dataSource;
  UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final users = await dataSource.getAllUsers();
      return Right(users);
    } catch (_) {
      return Left(ServerFailure("Failed to fetch users."));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserRole(
    String uid,
    String newRole,
  ) async {
    try {
      await dataSource.updateUserRole(uid, newRole);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure("Failed to update role."));
    }
  }

  @override
  Future<Either<Failure, void>> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    required String? phoneNumber,
    required String? gender,
    required DateTime? birthDate,
    required String? fcmToken,
  }) async {
    try {
      await dataSource.addUser(name, email, password, role);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure("Failed to add user."));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await dataSource.deleteUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
