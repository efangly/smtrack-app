import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/configs/url.dart';
import 'package:temp_noti/src/widgets/home/subtitle_list.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class MachineList extends StatefulWidget {
  const MachineList({super.key});

  @override
  State<MachineList> createState() => _MachineListState();
}

class _MachineListState extends State<MachineList> {
  Timer? _timer;
  late String ward;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      context.read<DevicesBloc>().add(GetDevices(ward));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    return BlocBuilder<DevicesBloc, DevicesState>(
      builder: (context, device) {
        ward = device.wardId;
        if (device.isError) {
          context.read<DevicesBloc>().add(const DeviceError(false));
          ShowSnackbar.snackbar(ContentType.failure, "เกิดข้อผิดพลาด", "ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้");
        }
        if (device.devices.isEmpty) {
          return const Center(child: Text("ไม่พบอุปกรณ์", style: TextStyle(color: Colors.white70, fontSize: 20)));
        } else {
          return ListView.separated(
            itemCount: device.devices.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.white12,
              height: 4,
              indent: 15,
              endIndent: 15,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  device.devices[index].name ?? "ไม่มีชื่อ",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: isTablet ? 22 : 16,
                  ),
                ),
                tileColor: const Color.fromARGB(255, 165, 190, 202),
                subtitle: SubtitleList(deviceInfo: device.devices[index]),
                trailing: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: isTablet ? 100 : 44,
                    minHeight: isTablet ? 100 : 44,
                    maxWidth: isTablet ? 100 : 65,
                    maxHeight: isTablet ? 400 : 64,
                  ),
                  child: Image.network(
                    device.devices[index].positionPic ?? URL.DEFAULT_PIC,
                    fit: BoxFit.fill,
                    width: isTablet ? 200 : 55,
                    height: isTablet ? 400 : 200,
                  ),
                ),
                onTap: (() {
                  try {
                    Navigator.pushNamed(
                      context,
                      custom_route.Route.device,
                      arguments: {'name': device.devices[index].name!, 'serial': device.devices[index].serial!},
                    );
                  } catch (err) {
                    ShowSnackbar.snackbar(
                      ContentType.warning,
                      "Warning",
                      "อุปกรณ์นี้ตั้งค่าไม่สำเร็จ",
                    );
                  }
                }),
              );
            },
          );
        }
      },
    );
  }
}
