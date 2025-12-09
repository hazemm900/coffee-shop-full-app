// In shared_data/lib/entities/promotion.dart
import 'package:equatable/equatable.dart';

// --- نحدد الأنواع الثابتة لضمان عدم حدوث أخطاء إملائية ---
enum PromotionType { PROMO_CODE, AUTOMATIC }

enum DiscountType { PERCENTAGE, FIXED_AMOUNT, FREE_PRODUCT }

enum PromotionAppliesTo { ENTIRE_ORDER, CATEGORY, SPECIFIC_PRODUCTS }
// --------------------------------------------------------

class Promotion extends Equatable {
  final String id;
  final String title;
  final String description;
  final PromotionStatus status;
  final PromotionType type;
  final String? promoCode;
  final DiscountType discountType;
  final double discountValue;
  final List<String>? freeProductIDs;
  final double? minPurchaseAmount;
  final PromotionAppliesTo appliesTo;
  final List<String>? targetIDs;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String>? specificDays;
  final int? usageLimit;
  final int? usagePerUser;

  const Promotion({
    required this.id,
    required this.title,
    required this.description,
    this.status = PromotionStatus.INACTIVE,
    required this.type,
    this.promoCode,
    required this.discountType,
    required this.discountValue,
    this.freeProductIDs,
    this.minPurchaseAmount,
    this.appliesTo = PromotionAppliesTo.ENTIRE_ORDER,
    this.targetIDs,
    required this.startDate,
    this.endDate,
    this.specificDays,
    this.usageLimit,
    this.usagePerUser,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        type,
        promoCode,
        discountType,
        discountValue,
        freeProductIDs,
        minPurchaseAmount,
        appliesTo,
        targetIDs,
        startDate,
        endDate,
        specificDays,
        usageLimit,
        usagePerUser,
      ];
}

// --- نحدد حالة العرض أيضًا ---
enum PromotionStatus { ACTIVE, INACTIVE }
