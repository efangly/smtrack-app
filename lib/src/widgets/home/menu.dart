import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:badges/badges.dart' as badges;
import 'package:temp_noti/src/services/services.dart';

class ManuBar extends StatelessWidget {
  const ManuBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    return Row(
      children: [
        BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            return IconButton(
              padding: const EdgeInsets.all(12.0),
              icon: state.notifications.isEmpty
                  ? Icon(Icons.notifications, size: isTablet ? 45 : 30)
                  : badges.Badge(
                      badgeContent: Text(
                        "${state.notifications.length > 99 ? '99+' : state.notifications.length}",
                        style: const TextStyle(color: Colors.white, fontSize: 8),
                      ),
                      position: badges.BadgePosition.topEnd(top: isTablet ? -1 : -5, end: isTablet ? -1 : -5),
                      child: Icon(Icons.notifications, size: isTablet ? 45 : 30),
                    ),
              onPressed: () {
                Api.getNotification().then((value) {
                  if (context.mounted) context.read<NotificationsBloc>().add(GetAllNotifications(value));
                }).catchError((error) {
                  if (kDebugMode) print(error.toString());
                  if (context.mounted) UtilsApp.pushToLogin(context);
                });
                Navigator.pushNamed(context, custom_route.Route.notification);
              },
            );
          },
        ),
        IconButton(
          padding: const EdgeInsets.all(12.0),
          icon: Icon(Icons.settings, size: isTablet ? 45 : 30),
          onPressed: () => Navigator.pushNamed(context, custom_route.Route.setting),
        ),
      ],
    );
  }
}
