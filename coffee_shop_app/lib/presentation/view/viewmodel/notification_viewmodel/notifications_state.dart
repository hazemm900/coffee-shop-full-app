import 'package:equatable/equatable.dart';
import 'package:shared_data/entities/notification.dart';

class NotificationsState extends Equatable {
  final ViewStatus status;
  final List<AppNotification> notifications;
  final String? errorMessage;

  const NotificationsState({
    this.status = ViewStatus.initial,
    this.notifications = const [],
    this.errorMessage,
  });

  NotificationsState copyWith({
    ViewStatus? status,
    List<AppNotification>? notifications,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notifications, errorMessage];
}

enum ViewStatus { initial, loading, success, error }
