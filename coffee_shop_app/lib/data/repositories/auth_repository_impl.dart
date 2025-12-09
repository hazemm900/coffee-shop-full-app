import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firebase_auth_datasource.dart';
import 'package:coffee_shop_app/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_data/entities/user.dart';
import 'package:shared_data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final firebaseUser = await dataSource.login(email, password);
      return Right(UserModel.fromFirebaseUser(firebaseUser) as User);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? "An unknown error occurred."));
    } catch (e) {
      return const Left(ServerFailure("An unexpected error occurred."));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required DateTime birthDate,
  }) async {
    try {
      final firebaseUser = await dataSource.register(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        gender: gender,
        birthDate: birthDate,
      );
      return Right(UserModel.fromFirebaseUser(firebaseUser) as User);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(
        ServerFailure(e.message ?? "An unknown registration error occurred."),
      );
    } catch (e) {
      return const Left(ServerFailure("An unexpected error occurred."));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await dataSource.logout();
      return const Right(null); // Right(null) is equivalent to Right(void)
    } catch (e) {
      return const Left(ServerFailure("Failed to logout."));
    }
  }
}
