import 'package:equatable/equatable.dart';
import 'package:shared_data/entities/promotion.dart';

enum PromotionSaveStatus { initial, loading, success, error }

class AddEditPromotionState extends Equatable {
  final PromotionSaveStatus status;
  final String? message;

  // promotion fields
  final PromotionType type;
  final DiscountType discountType;
  final PromotionAppliesTo appliesTo;
  final PromotionStatus statusValue;
  final DateTime? startDate;
  final DateTime? endDate;

  const AddEditPromotionState({
    this.status = PromotionSaveStatus.initial,
    this.message,
    this.type = PromotionType.AUTOMATIC,
    this.discountType = DiscountType.PERCENTAGE,
    this.appliesTo = PromotionAppliesTo.ENTIRE_ORDER,
    this.statusValue = PromotionStatus.INACTIVE,
    this.startDate,
    this.endDate,
  });

  AddEditPromotionState copyWith({
    PromotionSaveStatus? status,
    String? message,
    PromotionType? type,
    DiscountType? discountType,
    PromotionAppliesTo? appliesTo,
    PromotionStatus? statusValue,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return AddEditPromotionState(
      status: status ?? this.status,
      message: message ?? this.message,
      type: type ?? this.type,
      discountType: discountType ?? this.discountType,
      appliesTo: appliesTo ?? this.appliesTo,
      statusValue: statusValue ?? this.statusValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    type,
    discountType,
    appliesTo,
    statusValue,
    startDate,
    endDate,
  ];
}
