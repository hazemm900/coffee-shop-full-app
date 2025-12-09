// lib/domain/usecases/get_active_promotions_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../core/error/failures.dart';
import '../repositories/promotion_repository.dart';

class GetActivePromotionsUsecase {
  final PromotionRepository repository;
  GetActivePromotionsUsecase(this.repository);

  Future<Either<Failure, List<Promotion>>> execute() {
    return repository.getActiveAutomaticPromotions();
  }
}
