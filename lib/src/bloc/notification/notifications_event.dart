part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotifications extends NotificationsEvent {}

class GetLegacyNotifications extends NotificationsEvent {}

class NotificationError extends NotificationsEvent {
  final bool error;

  const NotificationError(this.error);

  @override
  List<Object> get props => [error];
}
