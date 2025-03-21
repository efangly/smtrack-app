import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/models/notifications.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/notification/noti_icon.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/convert.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    Future<void> getNoti() async {
      try {
        List<NotiList> noti = await Api.getNotification();
        if (context.mounted) context.read<NotificationsBloc>().add(GetAllNotifications(noti));
      } catch (error) {
        if (kDebugMode) print(error.toString());
        if (context.mounted) UtilsApp.pushToLogin(context);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isTablet ? 80 : 70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: isTablet ? 40 : 30, color: Colors.white60),
              ),
              Text(
                "Notification",
                style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900),
              ),
              const NotificationBtn(),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        child: BlocBuilder<NotificationsBloc, NotificationsState>(builder: (context, state) {
          if (state.notifications.isEmpty) return const Center(child: Text("No Notification"));
          return RefreshIndicator(
            onRefresh: () async {
              await getNoti();
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.separated(
              itemCount: state.notifications.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.white12, height: isTablet ? 3 : 1),
              itemBuilder: (BuildContext context, int index) {
                String detail = state.notifications[index].notiDetail ?? "-/-";
                return ListTile(
                  leading: ConvertMessage.showIcon(state.notifications[index].notiDetail ?? "-/-", isTablet ? 35 : 30),
                  title: Text(
                    state.notifications[index].device!.devDetail ?? "-",
                    style: TextStyle(fontSize: isTablet ? 21 : 14),
                  ),
                  tileColor: const Color.fromARGB(255, 165, 190, 202),
                  subtitle: Text(
                    ConvertMessage.setNotiMsg(detail),
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
        }),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
