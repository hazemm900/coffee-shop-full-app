import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_data/entities/promotion.dart';
import '../../viewmodel/promotions_viewmodel/add_edit_promotion_state.dart';
import '../../viewmodel/promotions_viewmodel/add_edit_promotion_viewmodel.dart';
import 'widgets/promotion_basic_info_section.dart';
import 'widgets/promotion_discount_section.dart';
import 'widgets/promotion_rules_section.dart';
import 'widgets/promotion_validity_section.dart';
import 'widgets/promotion_status_section.dart';
import 'widgets/promotion_save_button.dart';

class AddEditPromotionPage extends StatelessWidget {
  final Promotion? promotion;

  const AddEditPromotionPage({super.key, this.promotion});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AddEditPromotionViewModel, AddEditPromotionState>(
      listener: (context, state) {
        if (state.status == PromotionSaveStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "Saved successfully")),
          );
          Navigator.pop(context, true);
        } else if (state.status == PromotionSaveStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "Something went wrong")),
          );
        }
      },
      builder: (context, state) {
        final vm = context.read<AddEditPromotionViewModel>();

        // Controllers
        final titleController = TextEditingController(
          text: promotion?.title ?? '',
        );
        final descriptionController = TextEditingController(
          text: promotion?.description ?? '',
        );
        final promoCodeController = TextEditingController(
          text: promotion?.promoCode ?? '',
        );
        final discountValueController = TextEditingController(
          text: promotion?.discountValue?.toString() ?? '',
        );
        final minPurchaseController = TextEditingController(
          text: promotion?.minPurchaseAmount?.toString() ?? '',
        );
        final usageLimitController = TextEditingController(
          text: promotion?.usageLimit?.toString() ?? '',
        );
        final usagePerUserController = TextEditingController(
          text: promotion?.usagePerUser?.toString() ?? '',
        );

        final formKey = GlobalKey<FormState>();

        Future<void> pickDate({required bool isStart}) async {
          final picked = await showDatePicker(
            context: context,
            initialDate: isStart
                ? state.startDate ?? DateTime.now()
                : state.endDate ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            vm.updateDates(isStart: isStart, date: picked);
          }
        }

        void onSave() {
          if (!formKey.currentState!.validate()) return;

          final newPromotion = Promotion(
            id: promotion?.id ?? '',
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            status: state.statusValue,
            type: state.type,
            promoCode: state.type == PromotionType.PROMO_CODE
                ? promoCodeController.text.trim()
                : null,
            discountType: state.discountType,
            discountValue:
                double.tryParse(discountValueController.text.trim()) ?? 0,
            freeProductIDs: const [],
            minPurchaseAmount:
                double.tryParse(minPurchaseController.text.trim()) ?? 0,
            appliesTo: state.appliesTo,
            targetIDs: const [],
            startDate: state.startDate ?? DateTime.now(),
            endDate: state.endDate,
            specificDays: const [],
            usageLimit: int.tryParse(usageLimitController.text.trim()),
            usagePerUser: int.tryParse(usagePerUserController.text.trim()),
          );

          vm.savePromotion(newPromotion, promotion != null);
        }

        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            title: Text(
              promotion == null ? 'Add Promotion' : 'Edit Promotion',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        PromotionBasicInfoSection(
                          titleController: titleController,
                          descriptionController: descriptionController,
                        ),
                        PromotionDiscountSection(
                          type: state.type,
                          discountType: state.discountType,
                          promoCodeController: promoCodeController,
                          discountValueController: discountValueController,
                          onTypeChanged: (v) => vm.updateType(v!),
                          onDiscountTypeChanged: (v) =>
                              vm.updateDiscountType(v!),
                        ),
                        PromotionRulesSection(
                          appliesTo: state.appliesTo,
                          minPurchaseController: minPurchaseController,
                          usageLimitController: usageLimitController,
                          usagePerUserController: usagePerUserController,
                          onAppliesToChanged: (v) => vm.updateAppliesTo(v!),
                        ),
                        PromotionValiditySection(
                          startDate: state.startDate ?? DateTime.now(),
                          endDate: state.endDate ?? DateTime.now(),
                          onPickDate: pickDate,
                        ),
                        PromotionStatusSection(
                          status: state.statusValue,
                          onStatusChanged: (v) => vm.updateStatus(v!),
                        ),
                        PromotionSaveButton(
                          isLoading:
                              state.status == PromotionSaveStatus.loading,
                          onSave: onSave,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
