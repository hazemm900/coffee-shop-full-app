// lib/domain/repositories/promotion_repository.dart
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../core/error/failures.dart';

abstract class PromotionRepository {
  Future<Either<Failure, List<Promotion>>> getActiveAutomaticPromotions();
  Future<Either<Failure, Promotion>> validatePromoCode(String code);
}
