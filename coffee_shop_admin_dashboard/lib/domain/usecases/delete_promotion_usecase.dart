import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../repositories/promotion_repository.dart';

class DeletePromotionUseCase {
  final PromotionRepository repository;

  DeletePromotionUseCase(this.repository);

  Future<Either<Failure, void>> call(String promotionId) async {
    return await repository.deletePromotion(promotionId);
  }
}
