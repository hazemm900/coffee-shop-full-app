import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../repositories/promotion_repository.dart';
import '../../core/error/failures.dart';

class GetPromotionsUsecase {
  final PromotionRepository repository;
  GetPromotionsUsecase(this.repository);
  Future<Either<Failure, List<Promotion>>> execute() =>
      repository.getPromotions();
}
