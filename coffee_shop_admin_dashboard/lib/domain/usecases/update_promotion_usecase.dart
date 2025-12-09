import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../../../core/error/failures.dart';
import '../repositories/promotion_repository.dart';

class UpdatePromotionUseCase {
  final PromotionRepository repository;
  UpdatePromotionUseCase(this.repository);

  Future<Either<Failure, void>> execute(Promotion promotion) {
    return repository.updatePromotion(promotion);
  }
}
