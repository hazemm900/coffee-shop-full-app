import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/user.dart';
import '../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class GetAllUsersUsecase {
  final UserRepository repository;
  GetAllUsersUsecase(this.repository);
  Future<Either<Failure, List<User>>> execute() => repository.getAllUsers();
}
