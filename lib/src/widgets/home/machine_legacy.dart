import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class MachineLegacy extends StatefulWidget {
  const MachineLegacy({super.key});

  @override
  State<MachineLegacy> createState() => _MachineLegacyState();
}

class _MachineLegacyState extends State<MachineLegacy> {
  Timer? _timer;
  String ward = "";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      context.read<DevicesBloc>().add(GetLegacyDevices(ward));
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
        if (device.isError) {
          context.read<DevicesBloc>().add(const DeviceError(false));
          ShowSnackbar.snackbar(ContentType.failure, "เกิดข้อผิดพลาด", "ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้");
        }
        if (device.legacyDevice.isEmpty) {
          const Center(child: Text("ไม่พบอุปกรณ์", style: TextStyle(color: Colors.white70, fontSize: 20)));
        }
        if (device.legacyDevice.isNotEmpty) ward = device.legacyDevice.first.ward!;
        return ListView.separated(
          itemCount: device.legacyDevice.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.white12,
            height: 4,
            indent: 15,
            endIndent: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                device.legacyDevice[index].name ?? "ไม่มีชื่อ",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: isTablet ? 22 : 16,
                ),
              ),
              tileColor: const Color.fromARGB(255, 165, 190, 202),
              subtitle: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const SizedBox(width: 2),
                  Text(
                    device.legacyDevice[index].sn!,
                    style: TextStyle(fontSize: isTablet ? 20 : 14),
                  ),
                ],
              ),
              trailing: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 65,
                  maxHeight: 64,
                ),
                child: Center(
                  child: Text(
                    device.legacyDevice[index].log!.length.toString(),
                    style: TextStyle(fontSize: isTablet ? 20 : 14, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              onTap: (() {
                Navigator.pushNamed(
                  context,
                  custom_route.Route.legacy,
                  arguments: {'serial': device.legacyDevice[index].sn!, 'name': device.legacyDevice[index].name!},
                );
              }),
            );
          },
        );
      },
    );
  }
}
