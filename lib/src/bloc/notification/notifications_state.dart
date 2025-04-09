part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final List<NotiList> notifications;
  final List<LegacyNotificationList> legacyNotifications;
  final bool isError;
  const NotificationsState({this.notifications = const [], this.legacyNotifications = const [], this.isError = false});

  NotificationsState copyWith({
    List<NotiList>? notifications,
    List<LegacyNotificationList>? legacyNotifications,
    bool? isError,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      legacyNotifications: legacyNotifications ?? this.legacyNotifications,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [notifications, legacyNotifications, isError];
}
