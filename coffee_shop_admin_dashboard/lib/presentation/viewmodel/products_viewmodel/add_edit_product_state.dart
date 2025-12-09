import 'package:equatable/equatable.dart';

enum FormStatus { initial, loading, success, error }

class AddEditProductState extends Equatable {
  final FormStatus status;
  final String? errorMessage;

  const AddEditProductState({
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  AddEditProductState copyWith({FormStatus? status, String? errorMessage}) {
    return AddEditProductState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
