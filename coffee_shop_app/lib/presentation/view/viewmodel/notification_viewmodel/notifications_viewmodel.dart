import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_notifications_stream_usecase.dart';
import '../../../../core/error/failures.dart';
import 'notifications_state.dart';

class NotificationsViewModel extends Cubit<NotificationsState> {
  final GetNotificationsStreamUsecase getNotificationsStreamUsecase;
  StreamSubscription? _notificationsSubscription;

  NotificationsViewModel({required this.getNotificationsStreamUsecase})
    : super(const NotificationsState()) {
    _listenToNotifications();
  }

  void _listenToNotifications() {
    emit(state.copyWith(status: ViewStatus.loading));

    _notificationsSubscription = getNotificationsStreamUsecase.execute().listen(
      (either) {
        either.fold(
          (failure) {
            emit(
              state.copyWith(
                status: ViewStatus.error,
                errorMessage: _mapFailureToMessage(failure),
              ),
            );
          },
          (notifications) {
            emit(
              state.copyWith(
                status: ViewStatus.success,
                notifications: notifications,
              ),
            );
          },
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.message;
    return 'Unexpected error occurred';
  }

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
