import 'package:coffee_shop_admin_dashboard/domain/usecases/delete_promotion_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_promotions_usecase.dart';
import 'promotions_state.dart';

class PromotionsViewModel extends Cubit<PromotionsState> {
  final GetPromotionsUsecase getPromotionsUsecase;
  final DeletePromotionUseCase deletePromotionUseCase;

  PromotionsViewModel(this.getPromotionsUsecase, this.deletePromotionUseCase)
    : super(const PromotionsState());

  Future<void> fetchPromotions() async {
    emit(state.copyWith(status: ViewStatus.loading));

    final result = await getPromotionsUsecase.execute();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ViewStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (promotions) => emit(
        state.copyWith(status: ViewStatus.success, promotions: promotions),
      ),
    );
  }

  Future<void> deletePromotion(String id) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await deletePromotionUseCase(id);

    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.error, errorMessage: failure.message),
      ),
      (_) async {
        await fetchPromotions(); // نحدث القائمة بعد الحذف
        emit(
          state.copyWith(
            status: ViewStatus.success,
            errorMessage: "Promotion deleted successfully!",
          ),
        );
      },
    );
  }
}
