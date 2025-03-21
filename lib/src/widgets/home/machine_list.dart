import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/constants/url.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/home/subtitle_list.dart';

class MachineList extends StatelessWidget {
  const MachineList({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    Future<void> refreshData() async {
      try {
        List<DeviceList> device = await Api.getDevice();
        List<NotiList> noti = await Api.getNotification();
        if (context.mounted) {
          context.read<DevicesBloc>().add(GetAllDevices(device));
          context.read<NotificationsBloc>().add(GetAllNotifications(noti));
        }
      } on Exception catch (e) {
        if (kDebugMode) print(e);
        if (context.mounted) UtilsApp.pushToLogin(context);
      }
      await Future.delayed(const Duration(seconds: 1));
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        List<DeviceList> device = await Api.getDevice();
        List<NotiList> noti = await Api.getNotification();
        if (context.mounted) {
          UtilsApp.showSnackBar(
            context,
            ContentType.help,
            message.notification?.title ?? "",
            message.notification?.body ?? "",
          );
          context.read<DevicesBloc>().add(GetAllDevices(device));
          context.read<NotificationsBloc>().add(GetAllNotifications(noti));
        }
      } on Exception catch (e) {
        if (kDebugMode) print(e);
        if (context.mounted) UtilsApp.pushToLogin(context);
      }
    });

    return RefreshIndicator(
      onRefresh: refreshData,
      child: BlocBuilder<DevicesBloc, DevicesState>(builder: (context, state) {
        List<DeviceList> devices = state.devices.where((e) => e.wardId == state.wardId).toList();
        if (devices.isEmpty) return const Center(child: Text("No Device"));
        return ListView.separated(
          itemCount: devices.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.white12,
            height: 1,
            indent: 15,
            endIndent: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                devices[index].devDetail ?? "ไม่มีชื่อ",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: isTablet ? 22 : 16,
                ),
              ),
              tileColor: const Color.fromARGB(255, 165, 190, 202),
              subtitle: SubtitleList(deviceInfo: devices[index]),
              trailing: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 65,
                  maxHeight: 64,
                ),
                child: Image.network(
                  "${URL.BASE_URL}${devices[index].locPic ?? "/img/default-pic.png"}",
                  fit: BoxFit.cover,
                  width: isTablet ? 85 : 55,
                  height: isTablet ? 220 : 200,
                ),
              ),
              onTap: (() {
                try {
                  Navigator.pushNamed(
                    context,
                    custom_route.Route.detail,
                    arguments: {
                      'id': devices[index].devId!,
                      'serial': devices[index].devSerial!,
                      'name': devices[index].devDetail ?? "ไม่มีชื่อ",
                      'loc': devices[index].locInstall ?? "-",
                      'status': devices[index].alarm ?? false,
                      'humMin': devices[index].probe![0].humMin ?? 0,
                      'humMax': devices[index].probe![0].humMax ?? 0,
                      'tempMin': devices[index].probe![0].tempMin ?? 0,
                      'tempMax': devices[index].probe![0].tempMax ?? 0,
                    },
                  );
                } catch (err) {
                  UtilsApp.showSnackBar(
                    context,
                    ContentType.warning,
                    "Warning",
                    "อุปกรณ์นี้ตั้งค่าไม่สำเร็จ",
                  );
                }
              }),
            );
          },
        );
      }),
    );
  }
}
