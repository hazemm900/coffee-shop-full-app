import 'package:coffee_shop_admin_dashboard/domain/usecases/register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_data/entities/user.dart';

part 'register_state.dart';

class RegisterViewModel extends Cubit<RegisterState> {
  final RegisterUsecase registerUsecase;
  RegisterViewModel(this.registerUsecase) : super(RegisterInitial());

  // Controllers & formKey
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdateController = TextEditingController();
  final roleController = TextEditingController();

  String? gender;
  DateTime? birthDate;

  final formKey = GlobalKey<FormState>();

  // --- Update values ---
  void updateGender(String value) {
    gender = value;
    emit(RegisterInitial()); // مجرد إعادة بناء بسيطة
  }

  void updateBirthDate(DateTime value) {
    birthDate = value;
    birthdateController.text = "${value.toLocal()}".split(
      ' ',
    )[0]; // لعرض التاريخ
    emit(RegisterInitial());
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String gender,
    required DateTime birthDate,
    required String role,
  }) async {
    emit(RegisterLoading());
    final result = await registerUsecase.execute(
      name: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDate: birthDate,
      role: role,
    );
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (user) => emit(RegisterSuccess(user)),
    );
  }

  void submitRegister() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid || gender == null || birthDate == null) return;

    registerUser(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      gender: gender!,
      birthDate: birthDate!,
      role: roleController.text.trim(),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    birthdateController.dispose();
    return super.close();
  }
}
