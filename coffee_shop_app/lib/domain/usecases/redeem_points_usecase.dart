import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class RedeemPointsUsecase {
  final UserRepository repository;
  RedeemPointsUsecase(this.repository);

  Future<Either<Failure, void>> execute(int points) {
    return repository.redeemPoints(points);
  }
}
