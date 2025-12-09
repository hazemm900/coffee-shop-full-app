import 'package:coffee_shop_admin_dashboard/core/error/failures.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class AddUserUsecase {
  final UserRepository repository;
  AddUserUsecase(this.repository);

  Future<Either<Failure, void>> execute({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phoneNumber,
    String? gender,
    DateTime? birthDate,
    String? fcmToken,
  }) {
    return repository.addUser(
      name: name,
      email: email,
      password: password,
      role: role,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDate: birthDate,
      fcmToken: fcmToken,
    );
  }
}
