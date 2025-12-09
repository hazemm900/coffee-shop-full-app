import 'package:equatable/equatable.dart';
import 'package:shared_data/entities/promotion.dart';

enum ViewStatus { initial, loading, success, failure, error }

class PromotionsState extends Equatable {
  final ViewStatus status;
  final List<Promotion> promotions;
  final String? errorMessage;

  const PromotionsState({
    this.status = ViewStatus.initial,
    this.promotions = const [],
    this.errorMessage,
  });

  PromotionsState copyWith({
    ViewStatus? status,
    List<Promotion>? promotions,
    String? errorMessage,
  }) {
    return PromotionsState(
      status: status ?? this.status,
      promotions: promotions ?? this.promotions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, promotions, errorMessage];
}
