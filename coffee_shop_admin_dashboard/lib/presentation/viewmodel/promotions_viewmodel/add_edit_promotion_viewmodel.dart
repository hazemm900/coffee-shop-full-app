import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/add_promotion_usecase.dart';
import '../../../domain/usecases/update_promotion_usecase.dart';
import 'add_edit_promotion_state.dart';

class AddEditPromotionViewModel extends Cubit<AddEditPromotionState> {
  final AddPromotionUseCase addPromotionUsecase;
  final UpdatePromotionUseCase updatePromotionUsecase;

  AddEditPromotionViewModel({
    required this.addPromotionUsecase,
    required this.updatePromotionUsecase,
  }) : super(
         AddEditPromotionState(
           startDate: DateTime.now(),
           endDate: DateTime.now().add(const Duration(days: 30)),
         ),
       );

  // 🧩 Load promotion for editing
  void initializeFromPromotion(Promotion? promotion) {
    if (promotion == null) return;
    emit(
      state.copyWith(
        type: promotion.type,
        discountType: promotion.discountType,
        appliesTo: promotion.appliesTo,
        statusValue: promotion.status,
        startDate: promotion.startDate,
        endDate: promotion.endDate,
      ),
    );
  }

  // 🧱 Update individual fields
  void updateType(PromotionType value) => emit(state.copyWith(type: value));

  void updateDiscountType(DiscountType value) =>
      emit(state.copyWith(discountType: value));

  void updateAppliesTo(PromotionAppliesTo value) =>
      emit(state.copyWith(appliesTo: value));

  void updateStatus(PromotionStatus value) =>
      emit(state.copyWith(statusValue: value));

  void updateDates({required bool isStart, required DateTime date}) {
    if (isStart) {
      emit(state.copyWith(startDate: date));
    } else {
      emit(state.copyWith(endDate: date));
    }
  }

  // 💾 Save or update promotion
  Future<void> savePromotion(Promotion promotion, bool isEditing) async {
    emit(state.copyWith(status: PromotionSaveStatus.loading));

    Either<Failure, void> result;

    if (isEditing) {
      result = await updatePromotionUsecase.execute(promotion);
    } else {
      result = await addPromotionUsecase.execute(promotion);
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PromotionSaveStatus.error,
          message: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: PromotionSaveStatus.success,
          message: isEditing
              ? "Promotion updated successfully!"
              : "Promotion added successfully!",
        ),
      ),
    );
  }

  void reset() {
    emit(
      AddEditPromotionState(
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
      ),
    );
  }
}
