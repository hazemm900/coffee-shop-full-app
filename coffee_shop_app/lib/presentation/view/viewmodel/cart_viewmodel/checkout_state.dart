part of 'checkout_viewmodel.dart';

class CheckoutState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final int pointsToRedeem;
  final double discountAmount;
  final String? pointsError; // 👈 أضفنا ده

  const CheckoutState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.pointsToRedeem = 0,
    this.discountAmount = 0.0,
    this.pointsError,
  });

  CheckoutState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
    int? pointsToRedeem,
    double? discountAmount,
    String? pointsError,
    bool clearPointsError = false, // 👈 علشان نفضي الخطأ بعد التصحيح
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
      pointsToRedeem: pointsToRedeem ?? this.pointsToRedeem,
      discountAmount: discountAmount ?? this.discountAmount,
      pointsError: clearPointsError ? null : pointsError ?? this.pointsError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    isSuccess,
    pointsToRedeem,
    discountAmount,
    pointsError,
  ];
}
