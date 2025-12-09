enum AddUserStatus { initial, loading, success, error }

class AddUserState {
  final AddUserStatus status;
  final String? message;

  const AddUserState({this.status = AddUserStatus.initial, this.message});

  AddUserState copyWith({AddUserStatus? status, String? message}) {
    return AddUserState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
