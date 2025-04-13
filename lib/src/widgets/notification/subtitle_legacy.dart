import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/models/legacy_notification.dart';

class SubtitleLegacy extends StatelessWidget {
  final LegacyNotificationList notification;
  final bool isTablet;
  const SubtitleLegacy({super.key, required this.notification, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state.role == "LEGACY_USER" || state.role == "LEGACY_ADMIN" || state.role == "ADMIN") {
          return Text(notification.probe ?? "-", style: TextStyle(fontSize: isTablet ? 18 : 12));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.probe ?? "-", style: TextStyle(fontSize: isTablet ? 18 : 12)),
            const SizedBox(height: 5),
            Text(notification.device!.name ?? "-", style: TextStyle(fontSize: isTablet ? 18 : 12)),
            const SizedBox(height: 5),
            Text(notification.device!.hospitalName ?? "-", style: TextStyle(fontSize: isTablet ? 18 : 12)),
          ],
        );
      },
    );
  }
}
