import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/delete_user_usecase.dart';

part 'delete_user_state.dart';

class DeleteUserViewModel extends Cubit<DeleteUserState> {
  final DeleteUserUsecase deleteUserUsecase;

  DeleteUserViewModel(this.deleteUserUsecase) : super(DeleteUserInitial());

  Future<void> deleteUser(String userId) async {
    emit(DeleteUserLoading());
    final result = await deleteUserUsecase.execute(userId);
    result.fold(
      (failure) => emit(DeleteUserError(failure.message)),
      (_) => emit(DeleteUserSuccess()),
    );
  }
}
