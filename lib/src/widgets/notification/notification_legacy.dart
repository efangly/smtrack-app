import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class NotificationLegacy extends StatefulWidget {
  const NotificationLegacy({super.key});

  @override
  State<NotificationLegacy> createState() => _NotificationLegacyState();
}

class _NotificationLegacyState extends State<NotificationLegacy> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().add(GetLegacyNotifications());
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (context.mounted) context.read<NotificationsBloc>().add(GetLegacyNotifications());
    });
    return BlocBuilder<NotificationsBloc, NotificationsState>(builder: (context, state) {
      if (state.isError) {
        ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถโหลดข้อมูลได้");
        context.read<NotificationsBloc>().add(const NotificationError(false));
      }
      if (state.legacyNotifications.isEmpty) return const Center(child: Text("ไม่มีการแจ้งเตือน"));
      return RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationsBloc>().add(GetLegacyNotifications());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.separated(
          itemCount: state.legacyNotifications.length,
          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.white12, height: isTablet ? 3 : 1),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                state.legacyNotifications[index].message ?? "-",
                style: TextStyle(fontSize: isTablet ? 21 : 14),
              ),
              tileColor: const Color.fromARGB(255, 165, 190, 202),
              subtitle: Text(
                state.legacyNotifications[index].probe ?? "-",
                style: TextStyle(fontSize: isTablet ? 18 : 12),
              ),
            );
          },
        ),
      );
    });
  }
}
