import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/widgets/utils/convert.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().add(GetAllNotifications());
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (context.mounted) context.read<NotificationsBloc>().add(GetAllNotifications());
    });
    return BlocBuilder<NotificationsBloc, NotificationsState>(builder: (context, state) {
      if (state.isError) {
        ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถโหลดข้อมูลได้");
        context.read<NotificationsBloc>().add(const NotificationError(false));
      }
      if (state.notifications.isEmpty) return const Center(child: Text("ไม่มีการแจ้งเตือน"));
      return RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationsBloc>().add(GetAllNotifications());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.separated(
          itemCount: state.notifications.length,
          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.white12, height: isTablet ? 3 : 1),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: ConvertMessage.showIcon(state.notifications[index].message ?? "-/-", isTablet ? 38 : 30),
              title: Text(
                state.notifications[index].device!.name ?? "-",
                style: TextStyle(fontSize: isTablet ? 21 : 14),
              ),
              tileColor: const Color.fromARGB(255, 165, 190, 202),
              subtitle: Text(
                state.notifications[index].detail ?? "-",
                style: TextStyle(fontSize: isTablet ? 18 : 12),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.notifications[index].createAt.toString().substring(11, 16),
                    style: TextStyle(fontSize: isTablet ? 16 : 10),
                  ),
                  Text(
                    state.notifications[index].createAt.toString().substring(0, 10),
                    style: TextStyle(fontSize: isTablet ? 16 : 10),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
