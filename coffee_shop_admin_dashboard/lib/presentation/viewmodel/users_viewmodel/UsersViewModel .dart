import 'package:coffee_shop_admin_dashboard/domain/usecases/get_all_users_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/update_user_role_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/UsersState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersViewModel extends Cubit<UsersState> {
  final GetAllUsersUsecase getAllUsersUsecase;
  final UpdateUserRoleUsecase updateUserRoleUsecase;

  UsersViewModel(this.getAllUsersUsecase, this.updateUserRoleUsecase)
    : super(const UsersState());

  Future<void> fetchAllUsers() async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await getAllUsersUsecase.execute();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ViewStatus.error,
          errorMessage: "Failed to load users",
        ),
      ),
      (users) => emit(state.copyWith(status: ViewStatus.success, users: users)),
    );
  }

  Future<void> changeUserRole(String uid, String newRole) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await updateUserRoleUsecase.execute(uid, newRole);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ViewStatus.error,
          errorMessage: "Failed to update role",
        ),
      ),
      (_) => fetchAllUsers(),
    );
  }
}
