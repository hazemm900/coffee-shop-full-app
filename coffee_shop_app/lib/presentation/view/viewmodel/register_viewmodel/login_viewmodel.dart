import 'package:coffee_shop_app/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_data/entities/user.dart';

part 'login_state.dart';

class LoginViewModel extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;

  LoginViewModel(this.loginUsecase) : super(LoginInitial());

  // controllers & form key moved to the cubit
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final result = await loginUsecase.execute(email, password);

    result.fold(
      (failure) {
        emit(LoginError(failure.message));
      },
      (user) {
        emit(LoginSuccess(user));
      },
    );
  }

  /// Called by the UI when pressing the login button.
  void submitLogin() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    login(email, password);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
