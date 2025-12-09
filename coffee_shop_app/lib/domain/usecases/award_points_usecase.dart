import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class AwardPointsUsecase {
  final UserRepository repository;
  AwardPointsUsecase(this.repository);

  Future<Either<Failure, void>> execute(double orderTotal) {
    return repository.awardPoints(orderTotal);
  }
}
