import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../core/error/failures.dart';
import '../repositories/promotion_repository.dart';

class ValidatePromoCodeUsecase {
  final PromotionRepository repository;
  ValidatePromoCodeUsecase(this.repository);

  Future<Either<Failure, Promotion>> execute(String code) {
    return repository.validatePromoCode(code);
  }
}
