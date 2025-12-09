import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/register_viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdaySelectionSection extends StatelessWidget {
  const BirthdaySelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterViewModel>();

    return TextFormField(
      controller: cubit.birthdateController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.calendar_today_outlined,
          color: AppColors.primary,
        ),
        labelText: 'Birth Date',
        labelStyle: const TextStyle(color: AppColors.primary),
        filled: true,
        fillColor: AppColors.backgroundLight,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (picked != null) cubit.updateBirthDate(picked);
      },
      validator: (v) =>
          (v == null || v.isEmpty) ? 'Select your birth date' : null,
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0);
  }
}
