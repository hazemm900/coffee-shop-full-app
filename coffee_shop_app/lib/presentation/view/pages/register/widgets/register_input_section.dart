import 'package:coffee_shop_app/presentation/view/pages/register/widgets/birthday_selection_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/register/widgets/gender_selection_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/register/widgets/input_field.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/register_viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegisterInputSection extends StatelessWidget {
  final RegisterViewModel cubit;
  const RegisterInputSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputField(
          controller: cubit.nameController,
          label: "Name",
          icon: Icons.person_outline,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Please enter your name' : null,
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 16),

        InputField(
          controller: cubit.emailController,
          label: "Email",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (v) =>
              (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
        ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),

        const SizedBox(height: 16),

        InputField(
          controller: cubit.passwordController,
          label: "Password",
          icon: Icons.lock_outline,
          obscureText: true,
          validator: (v) =>
              (v == null || v.length < 6) ? 'Min 6 characters' : null,
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 16),

        InputField(
          controller: cubit.phoneNumberController,
          label: "Phone Number",
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Enter phone number' : null,
        ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),

        const SizedBox(height: 16),

        // 👩‍🦰 Gender
        GenderSelectionSection(),

        const SizedBox(height: 16),

        // 📅 Birth Date
        BirthdaySelectionSection(),
      ],
    );
  }
}
