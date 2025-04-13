import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/constants/timer.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';

typedef ReturnToNormalVal = void Function(bool normalMsg);
typedef NotificationVal = void Function(bool notificationMsg);
typedef FirstMsgDelayVal = void Function(String firstMsgDelay);
typedef RepeatVal = void Function(String repeat);

class NotiSetting extends StatelessWidget {
  final ReturnToNormalVal onNormalMsg;
  final NotificationVal onNotificationMsg;
  final FirstMsgDelayVal onFirstMsgDelay;
  final RepeatVal onRepeat;
  final String serialNumber;
  final bool normalMsg;
  final bool notificationMsg;
  final String firstMsgDelay;
  final String repeat;
  const NotiSetting({
    super.key,
    required this.onNormalMsg,
    required this.onNotificationMsg,
    required this.onFirstMsgDelay,
    required this.onRepeat,
    required this.serialNumber,
    required this.normalMsg,
    required this.notificationMsg,
    required this.firstMsgDelay,
    required this.repeat,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: Responsive.isTablet ? 24 : 18, color: Colors.white70, fontWeight: FontWeight.bold);
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: Colors.white70,
              size: Responsive.isTablet ? 38 : 28,
            ),
            Text(
              "ตั้งค่าการแจ้งเตือน",
              style: TextStyle(fontSize: Responsive.isTablet ? 26 : 20, color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: Responsive.isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(" แจ้งอุณหภูมิกลับเข้าช่วง", style: style),
            Switch(
              value: normalMsg,
              onChanged: (bool value) => onNormalMsg(value),
              activeColor: Colors.green[800],
              activeTrackColor: Colors.green[400],
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.white70,
            ),
          ],
        ),
        SizedBox(height: Responsive.isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(" การแจ้งเตือน", style: style),
            Switch(
              value: notificationMsg,
              onChanged: (bool value) => onNotificationMsg(value),
              activeColor: Colors.green[800],
              activeTrackColor: Colors.green[400],
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.white70,
            ),
          ],
        ),
        SizedBox(height: Responsive.isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(" หน่วงการแจ้งเตือนครั้งแรก", style: style),
            SizedBox(
              width: 85,
              height: 40,
              child: DropdownMenu(
                initialSelection: firstMsgDelay.toString(),
                width: 90,
                inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                onSelected: (String? value) => onFirstMsgDelay(value!),
                dropdownMenuEntries: Timer.timeList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(" แจ้งเตือนซ้ำ", style: style),
            SizedBox(
              width: Responsive.isTablet ? 100 : 85,
              height: 40,
              child: DropdownMenu(
                initialSelection: repeat.toString(),
                width: Responsive.isTablet ? 100 : 90,
                inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                onSelected: (String? value) => onRepeat(value!),
                dropdownMenuEntries: Timer.timeList.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
