import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/preference.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';

class NotiSettingPage extends StatefulWidget {
  const NotiSettingPage({super.key});

  @override
  State<NotiSettingPage> createState() => _NotiSettingPageState();
}

class _NotiSettingPageState extends State<NotiSettingPage> {
  final configStorage = ConfigStorage();
  bool notification = false;
  bool door = false;
  bool legacy = false;
  String role = "";

  Future<void> loadValue() async {
    notification = await configStorage.getNotificationStatus() ?? false;
    door = await configStorage.getDoorStatus() ?? false;
    legacy = await configStorage.getLegacyStatus() ?? false;
    role = await configStorage.getRole() ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadValue();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: Responsive.isTablet ? 24 : 18, color: Colors.white70, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.isTablet ? 80 : 70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: Responsive.isTablet ? 40 : 30, color: Colors.white60),
              ),
              Text(
                "ตั้งค่าการแจ้งเตือน",
                style: TextStyle(fontSize: Responsive.isTablet ? 25 : 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: Responsive.isTablet ? 40 : 30),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("แจ้งเตือนอุณหภูมิ", style: style),
                Switch(
                  value: notification,
                  onChanged: (bool value) {
                    if (value) {
                      configStorage.setNotification(true);
                    } else {
                      configStorage.setNotification(false);
                    }
                    setState(() => notification = value);
                  },
                  activeColor: Colors.green[800],
                  activeTrackColor: Colors.green[400],
                  inactiveThumbColor: Colors.grey[600],
                  inactiveTrackColor: Colors.white70,
                ),
              ],
            ),
            const SizedBox(height: 10),
            role != "LEGACY_USER" || role != "LEGACY_ADMIN"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("แจ้งเตือนประตู", style: style),
                      Switch(
                        value: door,
                        onChanged: (bool value) {
                          if (value) {
                            configStorage.setDoorNotification(true);
                          } else {
                            configStorage.setDoorNotification(false);
                          }
                          setState(() => door = value);
                        },
                        activeColor: Colors.green[800],
                        activeTrackColor: Colors.green[400],
                        inactiveThumbColor: Colors.grey[600],
                        inactiveTrackColor: Colors.white70,
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 10),
            role == "SERVICE" || role == "SUPER"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("แจ้งเตือนระบบ Line", style: style),
                      Switch(
                        value: legacy,
                        onChanged: (bool value) {
                          if (value) {
                            configStorage.setLegacyNotification(true);
                          } else {
                            configStorage.setLegacyNotification(false);
                          }
                          setState(() => legacy = value);
                        },
                        activeColor: Colors.green[800],
                        activeTrackColor: Colors.green[400],
                        inactiveThumbColor: Colors.grey[600],
                        inactiveTrackColor: Colors.white70,
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
