part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotifications extends NotificationsEvent {
  final List<NotiList> notification;
  const GetAllNotifications(this.notification);

  @override
  List<Object> get props => [notification];
}
