import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, User>> execute({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required DateTime birthDate,
    required String role,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDate: birthDate,
      role: role,
    );
  }
}
