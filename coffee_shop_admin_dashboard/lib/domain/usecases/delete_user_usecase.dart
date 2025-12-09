import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository repository;

  DeleteUserUsecase(this.repository);

  Future<Either<Failure, void>> execute(String userId) {
    return repository.deleteUser(userId);
  }
}
