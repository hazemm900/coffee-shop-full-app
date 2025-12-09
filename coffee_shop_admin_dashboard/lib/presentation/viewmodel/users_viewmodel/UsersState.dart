import 'package:equatable/equatable.dart';
import 'package:shared_data/entities/user.dart';

enum ViewStatus { initial, loading, success, error }

class UsersState extends Equatable {
  final ViewStatus status;
  final List<User> users;
  final String? errorMessage;

  const UsersState({
    this.status = ViewStatus.initial,
    this.users = const [],
    this.errorMessage,
  });

  UsersState copyWith({
    ViewStatus? status,
    List<User>? users,
    String? errorMessage,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, users, errorMessage];
}
