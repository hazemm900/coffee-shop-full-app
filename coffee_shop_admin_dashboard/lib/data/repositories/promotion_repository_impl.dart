import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import 'package:shared_data/models/promotion_model.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/promotion_repository.dart';
import '../datasources/firestore_datasource.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final FirestoreDataSource dataSource;
  PromotionRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Promotion>>> getPromotions() async {
    try {
      final promotions = await dataSource.getPromotions();
      return Right(promotions);
    } catch (e) {
      return Left(ServerFailure("Failed to fetch promotions."));
    }
  }

  @override
  Future<Either<Failure, void>> addPromotion(Promotion promotion) async {
    try {
      final promotionModel = (promotion is PromotionModel)
          ? promotion
          : PromotionModel(
              id: promotion.id,
              title: promotion.title,
              description: promotion.description,
              status: promotion.status,
              type: promotion.type,
              promoCode: promotion.promoCode,
              discountType: promotion.discountType,
              discountValue: promotion.discountValue,
              freeProductIDs: promotion.freeProductIDs,
              minPurchaseAmount: promotion.minPurchaseAmount,
              appliesTo: promotion.appliesTo,
              targetIDs: promotion.targetIDs,
              startDate: promotion.startDate,
              endDate: promotion.endDate,
              specificDays: promotion.specificDays,
              usageLimit: promotion.usageLimit,
              usagePerUser: promotion.usagePerUser,
            );

      await dataSource.addPromotion(promotionModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePromotion(Promotion promotion) async {
    try {
      final promotionModel = (promotion is PromotionModel)
          ? promotion
          : PromotionModel(
              id: promotion.id,
              title: promotion.title,
              description: promotion.description,
              status: promotion.status,
              type: promotion.type,
              promoCode: promotion.promoCode,
              discountType: promotion.discountType,
              discountValue: promotion.discountValue,
              freeProductIDs: promotion.freeProductIDs,
              minPurchaseAmount: promotion.minPurchaseAmount,
              appliesTo: promotion.appliesTo,
              targetIDs: promotion.targetIDs,
              startDate: promotion.startDate,
              endDate: promotion.endDate,
              specificDays: promotion.specificDays,
              usageLimit: promotion.usageLimit,
              usagePerUser: promotion.usagePerUser,
            );

      await dataSource.updatePromotion(promotionModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePromotion(String promotionId) async {
    try {
      await dataSource.deletePromotion(promotionId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
