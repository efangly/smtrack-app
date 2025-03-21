part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotiList> notifications;
  const NotificationsState({this.notifications = const []});

  NotificationsState copyWith({List<NotiList>? notifications}) {
    return NotificationsState(notifications: notifications ?? this.notifications);
  }

  @override
  List<Object> get props => [notifications];
}
