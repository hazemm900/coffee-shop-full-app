import 'package:coffee_shop_app/core/theme/app_theme.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/register_viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionSection extends StatelessWidget {
  const GenderSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterViewModel>();

    return BlocBuilder<RegisterViewModel, RegisterState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: cubit.gender,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.wc_outlined, color: AppColors.primary),
            labelText: 'Gender',
            labelStyle: const TextStyle(color: AppColors.primary),
            filled: true,
            fillColor: AppColors.backgroundLight,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
          items: ['Male', 'Female'].map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (newValue) => cubit.updateGender(newValue!),
          validator: (v) => (v == null) ? 'Select your gender' : null,
        );
      },
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0);
  }
}
