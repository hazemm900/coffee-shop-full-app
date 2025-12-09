// lib/data/repositories/promotion_repository_impl.dart
import 'package:coffee_shop_app/core/error/failures.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:coffee_shop_app/domain/repositories/promotion_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  final FirestoreDataSource dataSource;
  PromotionRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Promotion>>>
  getActiveAutomaticPromotions() async {
    try {
      final promotions = await dataSource.getActiveAutomaticPromotions();
      return Right(promotions);
    } catch (e) {
      return Left(ServerFailure("Failed to fetch promotions."));
    }
  }

  @override
  Future<Either<Failure, Promotion>> validatePromoCode(String code) async {
    try {
      final promos = await dataSource.getPromotionByCode(
        code.trim().toUpperCase(),
      );

      // 1. التحقق إذا كان الكود موجودًا
      if (promos.isEmpty) {
        return Left(ServerFailure("Invalid or expired promo code."));
      }

      final promo = promos.first; // نأخذ أول نتيجة مطابقة

      // 2. التحقق من صلاحية التواريخ
      if (promo.startDate.isAfter(DateTime.now())) {
        return Left(ServerFailure("This promo code is not active yet."));
      }
      if (promo.endDate != null && promo.endDate!.isBefore(DateTime.now())) {
        return Left(ServerFailure("This promo code has expired."));
      }

      // TODO: إضافة التحقق من عدد مرات الاستخدام (usageLimit)

      return Right(promo);
    } catch (e) {
      return Left(ServerFailure("Failed to validate promo code."));
    }
  }
}
