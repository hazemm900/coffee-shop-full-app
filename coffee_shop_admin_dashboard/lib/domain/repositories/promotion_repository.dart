import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../core/error/failures.dart';

abstract class PromotionRepository {
  Future<Either<Failure, List<Promotion>>> getPromotions();
  Future<Either<Failure, void>> addPromotion(Promotion promotion);
  Future<Either<Failure, void>> updatePromotion(Promotion promotion);
  Future<Either<Failure, void>> deletePromotion(String promotionId);
}
