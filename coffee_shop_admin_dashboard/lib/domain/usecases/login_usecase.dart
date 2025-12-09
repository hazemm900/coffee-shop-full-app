import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, User>> execute(String email, String password) {
    return repository.login(email, password);
  }
}
