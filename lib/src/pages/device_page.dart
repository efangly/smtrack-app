import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/setting/noti_setting.dart';
import 'package:temp_noti/src/widgets/setting/schedule_setting.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SetupPage> {
  bool? normalMsg;
  bool? notificationMsg;
  String? firstMsgDelay;
  String? repeat;
  String? firstDay;
  String? secondDay;
  String? thirdDay;
  String? firstHour;
  String? firstMin;
  String? secondHour;
  String? secondMin;
  String? thirdHour;
  String? thirdMin;

  void initValue(DeviceList device) {
    normalMsg = device.config!.backToNormal == "1" ? true : false;
    notificationMsg = device.config!.mobileNoti == "1" ? true : false;
    firstMsgDelay = device.config!.notiTime.toString();
    repeat = device.config!.repeat.toString();
    firstDay = device.config!.firstDay;
    secondDay = device.config!.secondDay;
    thirdDay = device.config!.thirdDay;
    firstHour = device.config!.firstTime!.substring(0, 2);
    firstMin = device.config!.firstTime!.substring(2);
    secondHour = device.config!.secondTime!.substring(0, 2);
    secondMin = device.config!.secondTime!.substring(2);
    thirdHour = device.config!.thirdTime!.substring(0, 2);
    thirdMin = device.config!.thirdTime!.substring(2);
  }

  Future<void> warning(String title, String data) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.white70)),
          content: Text(data, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 0, 77, 192),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white60),
              child: const Text('OK', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
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
              Text(
                "Device Setting",
                style: TextStyle(fontSize: isTablet ? 25 : 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () async {
                  Configs configs = Configs(
                    config: NetworkConfig(
                      backToNormal: normalMsg! ? "1" : "0",
                      mobileNoti: notificationMsg! ? "1" : "0",
                      notiTime: int.parse(firstMsgDelay!),
                      repeat: int.parse(repeat!),
                      firstDay: firstDay!,
                      secondDay: secondDay!,
                      thirdDay: thirdDay!,
                      firstTime: firstHour! + firstMin!,
                      secondTime: secondHour! + secondMin!,
                      thirdTime: thirdHour! + thirdMin!,
                    ),
                  );
                  try {
                    bool result = await Api.updateDevice(arguments['serial'], configs);
                    if (result) {
                      List<DeviceList> device = await Api.getDevice();
                      await warning("Successful", "Device setting saved!!");
                      if (context.mounted) {
                        context.read<DevicesBloc>().add(GetAllDevices(device));
                        Navigator.of(context).pop();
                      }
                    } else {
                      await warning("Warning", "Failed to save device setting!!");
                    }
                  } catch (error) {
                    if (kDebugMode) print(error.toString());
                    if (context.mounted) UtilsApp.pushToLogin(context);
                  }
                },
                icon: FaIcon(
                  Icons.save,
                  size: isTablet ? 40 : 30,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(decoration: ConstColor.bgColor),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 8),
              child: SingleChildScrollView(
                child: BlocBuilder<DevicesBloc, DevicesState>(
                  builder: (context, state) {
                    if (firstHour == null) initValue(state.devices.where((e) => e.devSerial == arguments['serial']).first);
                    return Column(
                      children: [
                        NotiSetting(
                          serialNumber: arguments['serial'],
                          normalMsg: normalMsg!,
                          notificationMsg: notificationMsg!,
                          firstMsgDelay: firstMsgDelay!,
                          repeat: repeat!,
                          onNormalMsg: (bool msg) => setState(() => normalMsg = msg),
                          onNotificationMsg: (bool msg) => setState(() => notificationMsg = msg),
                          onFirstMsgDelay: (String msg) => setState(() => firstMsgDelay = msg),
                          onRepeat: (String msg) => setState(() => repeat = msg),
                        ),
                        ScheduleSetting(
                          serialNumber: arguments['serial'],
                          onFirstDay: (String day) => setState(() => firstDay = day),
                          onSecondDay: (String day) => setState(() => secondDay = day),
                          onThirdDay: (String day) => setState(() => thirdDay = day),
                          onFirstHour: (String hour) => setState(() => firstHour = hour),
                          onFirstMinute: (String min) => setState(() => firstMin = min),
                          onSecondHour: (String hour) => setState(() => secondHour = hour),
                          onSecondMinute: (String min) => setState(() => secondMin = min),
                          onThirdHour: (String hour) => setState(() => thirdHour = hour),
                          onThirdMinute: (String min) => setState(() => thirdMin = min),
                          firstDay: firstDay!,
                          secondDay: secondDay!,
                          thirdDay: thirdDay!,
                          firstHour: firstHour!,
                          firstMin: firstMin!,
                          secondHour: secondHour!,
                          secondMin: secondMin!,
                          thirdHour: thirdHour!,
                          thirdMin: thirdMin!,
                        ),
                        const SizedBox(height: 50),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
