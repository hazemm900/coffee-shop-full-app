import 'package:coffee_shop_admin_dashboard/domain/usecases/add_user_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/add_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserViewModel extends Cubit<AddUserState> {
  final AddUserUsecase addUserUsecase;

  AddUserViewModel(this.addUserUsecase) : super(const AddUserState());

  Future<void> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phoneNumber,
    String? gender,
    DateTime? birthDate,
    String? fcmToken,
  }) async {
    emit(state.copyWith(status: AddUserStatus.loading));

    final result = await addUserUsecase.execute(
      name: name,
      email: email,
      password: password,
      role: role,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDate: birthDate,
      fcmToken: fcmToken,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: AddUserStatus.error, message: failure.message),
      ),
      (_) => emit(
        state.copyWith(
          status: AddUserStatus.success,
          message: "User added successfully",
        ),
      ),
    );
  }
}
