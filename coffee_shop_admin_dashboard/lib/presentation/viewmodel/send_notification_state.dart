import 'package:equatable/equatable.dart';

enum FormStatus { initial, loading, success, error }

class SendNotificationState extends Equatable {
  final FormStatus status;
  final String? errorMessage;

  const SendNotificationState({
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  SendNotificationState copyWith({FormStatus? status, String? errorMessage}) {
    return SendNotificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
