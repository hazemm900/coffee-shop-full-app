import 'package:coffee_shop_app/presentation/view/pages/register/widgets/register_button_section.dart';
import 'package:coffee_shop_app/presentation/view/pages/register/widgets/register_input_section.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/register_viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterViewModel>();

    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🧾 Input Fields
              RegisterInputSection(cubit: cubit),

              const SizedBox(height: 24),

              // 🚀 Register Button
              RegisterButtonSection(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }
}
