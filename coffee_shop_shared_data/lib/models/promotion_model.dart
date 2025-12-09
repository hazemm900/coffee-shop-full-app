// In shared_data/lib/models/promotion_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_data/entities/promotion.dart';

class PromotionModel extends Promotion {
  const PromotionModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.type,
    super.promoCode,
    required super.discountType,
    required super.discountValue,
    super.freeProductIDs,
    super.minPurchaseAmount,
    required super.appliesTo,
    super.targetIDs,
    required super.startDate,
    super.endDate,
    super.specificDays,
    super.usageLimit,
    super.usagePerUser,
  });

  PromotionModel copyWith({
    String? id,
    String? title,
    String? description,
    PromotionStatus? status,
    PromotionType? type,
    String? promoCode,
    DiscountType? discountType,
    double? discountValue,
    List<String>? freeProductIDs,
    double? minPurchaseAmount,
    PromotionAppliesTo? appliesTo,
    List<String>? targetIDs,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? specificDays,
    int? usageLimit,
    int? usagePerUser,
  }) {
    return PromotionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      type: type ?? this.type,
      promoCode: promoCode ?? this.promoCode,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      freeProductIDs: freeProductIDs ?? this.freeProductIDs,
      minPurchaseAmount: minPurchaseAmount ?? this.minPurchaseAmount,
      appliesTo: appliesTo ?? this.appliesTo,
      targetIDs: targetIDs ?? this.targetIDs,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      specificDays: specificDays ?? this.specificDays,
      usageLimit: usageLimit ?? this.usageLimit,
      usagePerUser: usagePerUser ?? this.usagePerUser,
    );
  }

  // --- دالة لتحويل البيانات من Firestore إلى Model ---
  factory PromotionModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PromotionModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      status: (data['status'] == 'ACTIVE')
          ? PromotionStatus.ACTIVE
          : PromotionStatus.INACTIVE,
      type: (data['type'] == 'PROMO_CODE')
          ? PromotionType.PROMO_CODE
          : PromotionType.AUTOMATIC,
      promoCode: data['promoCode'],
      discountType: DiscountType.values.firstWhere(
        (e) => e.toString() == 'DiscountType.${data['discountType']}',
        orElse: () => DiscountType.FIXED_AMOUNT,
      ),
      discountValue: (data['discountValue'] as num? ?? 0).toDouble(),
      freeProductIDs: List<String>.from(data['freeProductIDs'] ?? []),
      minPurchaseAmount: (data['minPurchaseAmount'] as num?)?.toDouble(),
      appliesTo: PromotionAppliesTo.values.firstWhere(
        (e) => e.toString() == 'PromotionAppliesTo.${data['appliesTo']}',
        orElse: () => PromotionAppliesTo.ENTIRE_ORDER,
      ),
      targetIDs: List<String>.from(data['targetIDs'] ?? []),
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp?)?.toDate(),
      specificDays: List<String>.from(data['specificDays'] ?? []),
      usageLimit: data['usageLimit'],
      usagePerUser: data['usagePerUser'],
    );
  }

  // --- دالة لتحويل الـ Model إلى JSON لحفظه في Firestore ---
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'status': status.name,
      'type': type.name,
      'promoCode': promoCode,
      'discountType': discountType.name,
      'discountValue': discountValue,
      'freeProductIDs': freeProductIDs,
      'minPurchaseAmount': minPurchaseAmount,
      'appliesTo': appliesTo.name,
      'targetIDs': targetIDs,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'specificDays': specificDays,
      'usageLimit': usageLimit,
      'usagePerUser': usagePerUser,
      // لا نحفظ الـ ID كحقل، لأن الـ ID هو اسم المستند
    };
  }
}
