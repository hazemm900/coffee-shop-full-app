import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class GetUserProfileUsecase {
  final UserRepository repository;

  GetUserProfileUsecase(this.repository);

  Future<Either<Failure, User>> execute() {
    return repository.getUserProfile();
  }
}
