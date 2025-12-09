part of 'delete_user_viewmodel.dart';

abstract class DeleteUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteUserInitial extends DeleteUserState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {}

class DeleteUserError extends DeleteUserState {
  final String message;
  DeleteUserError(this.message);

  @override
  List<Object?> get props => [message];
}
