import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temp_noti/src/models/legacy_notification.dart';
import 'package:temp_noti/src/models/notifications.dart';
import 'package:temp_noti/src/services/services.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final Api api = Api();
  NotificationsBloc() : super(const NotificationsState()) {
    on<GetAllNotifications>(_onLoadNotification);
    on<GetLegacyNotifications>(_onLoadLegacyNotification);
    on<NotificationError>(_onError);
  }

  void _onLoadNotification(GetAllNotifications event, Emitter<NotificationsState> emit) async {
    try {
      List<NotiList> notifications = await api.getNotification();
      emit(state.copyWith(notifications: notifications));
    } on Exception catch (e) {
      emit(state.copyWith(isError: true));
      if (kDebugMode) print(e);
    }
  }

  void _onLoadLegacyNotification(GetLegacyNotifications event, Emitter<NotificationsState> emit) async {
    try {
      List<LegacyNotificationList> legacyNotification = await api.getLegacyNotification();
      emit(state.copyWith(legacyNotifications: legacyNotification));
    } on Exception catch (e) {
      emit(state.copyWith(isError: true));
      if (kDebugMode) print(e);
    }
  }

  void _onError(NotificationError event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(isError: event.error));
  }
}
