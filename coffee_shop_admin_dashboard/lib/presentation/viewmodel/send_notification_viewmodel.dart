import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/send_notification_usecase.dart';
import 'send_notification_state.dart';

class SendNotificationViewModel extends Cubit<SendNotificationState> {
  final SendNotificationUsecase sendNotificationUsecase;

  SendNotificationViewModel(this.sendNotificationUsecase)
    : super(const SendNotificationState());

  Future<void> send({required String title, required String body}) async {
    emit(state.copyWith(status: FormStatus.loading));

    final result = await sendNotificationUsecase.execute(
      title: title,
      body: body,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: FormStatus.error, errorMessage: failure.message),
      ),
      (_) => emit(state.copyWith(status: FormStatus.success)),
    );
  }
}
