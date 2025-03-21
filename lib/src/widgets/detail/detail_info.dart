import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/convert.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({super.key, required this.serial});
  final String serial;
  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    Future<void> getNoti() async {
      try {
        List<NotiList> noti = await Api.getNotification();
        if (context.mounted) context.read<NotificationsBloc>().add(GetAllNotifications(noti));
      } catch (error) {
        if (kDebugMode) print(error.toString());
        if (context.mounted) UtilsApp.pushToLogin(context);
      }
    }

    return BlocBuilder<NotificationsBloc, NotificationsState>(builder: (context, state) {
      final notiSerial = state.notifications.where((i) => i.devSerial == serial).toList();
      if (notiSerial.isEmpty) {
        return const Center(child: Text("No Notification"));
      }
      return RefreshIndicator(
        onRefresh: () async {
          await getNoti();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.separated(
          itemCount: notiSerial.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white12, height: 1),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(ConvertMessage.setNotiMsg(notiSerial[index].notiDetail ?? "-/-")),
              tileColor: const Color.fromARGB(255, 165, 190, 202),
              subtitle: Text(
                  "${notiSerial[index].createAt.toString().substring(0, 10)} | ${notiSerial[index].createAt.toString().substring(11, 16)}"),
              trailing: ConvertMessage.showIcon(notiSerial[index].notiDetail ?? "-/-", isTablet ? 35 : 30),
            );
          },
        ),
      );
    });
  }
}
