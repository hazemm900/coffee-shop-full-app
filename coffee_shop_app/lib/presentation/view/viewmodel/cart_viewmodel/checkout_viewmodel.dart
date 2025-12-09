import 'package:coffee_shop_app/core/service_locator.dart';
import 'package:coffee_shop_app/domain/repositories/cart_repository.dart';
import 'package:coffee_shop_app/domain/usecases/award_points_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/place_order_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/redeem_points_usecase.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/cart_item.dart';
import 'package:shared_data/entities/order.dart' as my_order;

part 'checkout_state.dart';

class CheckoutViewModel extends Cubit<CheckoutState> {
  final PlaceOrderUsecase placeOrderUsecase;
  final CartRepository cartRepository;
  final AwardPointsUsecase awardPointsUsecase;
  final RedeemPointsUsecase redeemPointsUsecase;

  CheckoutViewModel(
    this.placeOrderUsecase,
    this.cartRepository,
    this.awardPointsUsecase,
    this.redeemPointsUsecase,
  ) : super(const CheckoutState());

  /// تطبيق النقاط
  void applyPoints(int points, int userAvailablePoints, double maxDiscount) {
    if (points > userAvailablePoints) {
      emit(state.copyWith(pointsError: "You don't have enough points."));
      return;
    }

    double discount = points / 10.0; // 10 نقاط = 1 جنيه
    if (discount > maxDiscount) {
      discount = maxDiscount;
      points = (maxDiscount * 10).toInt();
    }

    emit(
      state.copyWith(
        pointsToRedeem: points,
        discountAmount: discount,
        clearPointsError: true,
      ),
    );
  }

  /// باقي الكود confirmOrder زي ما هو

  /// تأكيد الطلب
  Future<void> confirmOrder(
    List<CartItem> items,
    double originalTotalPrice,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(
        state.copyWith(
          isLoading: false,
          error: "You must be logged in to place an order.",
        ),
      );
      return;
    }

    final finalTotalPrice = originalTotalPrice - state.discountAmount;

    final order = my_order.OrderDetails(
      items: items,
      totalPrice: finalTotalPrice,
      userId: user.uid,
      timestamp: DateTime.now(),
      id: '',
      pointsRedeemed: state.pointsToRedeem,
      discountAmount: state.discountAmount,
    );

    final result = await placeOrderUsecase.execute(order);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) async {
        // خصم النقاط أولاً
        if (state.pointsToRedeem > 0) {
          await redeemPointsUsecase.execute(state.pointsToRedeem);
        }

        // منح النقاط على السعر النهائي
        await awardPointsUsecase.execute(finalTotalPrice);

        // تفريغ السلة
        await cartRepository.clearCart();
        sl<CartViewModel>().loadCartItems();

        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
