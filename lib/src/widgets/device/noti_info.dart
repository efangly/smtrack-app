import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/models/log.dart';
import 'package:temp_noti/src/widgets/utils/convert.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';

class NotificationInfo extends StatelessWidget {
  final String serial;
  const NotificationInfo({super.key, required this.serial});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevicesBloc, DevicesState>(
      builder: (context, state) {
        DeviceInfo device = state.devices.where((i) => i.serial == serial).toList().first;
        if (device.notification!.isEmpty) {
          return const Center(child: Text("ไม่มีข้อมูลการแจ้งเตือน"));
        }
        return ListView.separated(
          itemCount: device.notification!.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white12, height: 1),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(device.notification![index].detail ?? "-/-"),
              tileColor: const Color.fromARGB(255, 165, 190, 202),
              subtitle: Text(
                  "${device.notification![index].createAt.toString().substring(0, 10)} | ${device.notification![index].createAt.toString().substring(11, 16)}"),
              trailing: ConvertMessage.showIcon(device.notification![index].message ?? "-/-", Responsive.isTablet ? 35 : 30),
            );
          },
        );
      },
    );
  }
}
