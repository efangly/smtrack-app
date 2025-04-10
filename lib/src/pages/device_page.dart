import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/device/config_btn.dart';
import 'package:temp_noti/src/widgets/device/device_info.dart';
import 'package:temp_noti/src/widgets/device/noti_info.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final api = Api();
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      arguments['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              ConfigBtn(serial: arguments['serial'], isTablet: isTablet),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: FutureBuilder(
            future: api.getDeviceById(arguments['serial']),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถโหลดข้อมูลได้");
                Navigator.pop(context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: TextInputStyle.loading);
              }
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isTablet ? 350 : 320,
                      child: DeviceInfomation(device: snapshot.data!, isTablet: isTablet),
                    ),
                    Expanded(child: NotificationInfo(serial: arguments['serial'])),
                  ],
                );
              }
              return const Center(child: Text("ไม่พบข้อมูล"));
            },
          ),
        ),
      ),
    );
  }
}
