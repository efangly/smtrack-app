import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/constants/timer.dart';

typedef FirstDayFunc = void Function(String day);
typedef SecondDayFunc = void Function(String day);
typedef ThirdDayFunc = void Function(String day);
typedef FirstHour = void Function(String hour);
typedef SecondHour = void Function(String hour);
typedef ThirdHour = void Function(String hour);
typedef FirstMinute = void Function(String minute);
typedef SecondMinute = void Function(String minute);
typedef ThirdMinute = void Function(String minute);

class ScheduleSetting extends StatelessWidget {
  final String serialNumber;
  final FirstDayFunc onFirstDay;
  final SecondDayFunc onSecondDay;
  final ThirdDayFunc onThirdDay;
  final FirstHour onFirstHour;
  final SecondHour onSecondHour;
  final ThirdHour onThirdHour;
  final FirstMinute onFirstMinute;
  final SecondMinute onSecondMinute;
  final ThirdMinute onThirdMinute;
  final String secondDay;
  final String firstDay;
  final String thirdDay;
  final String firstHour;
  final String firstMin;
  final String secondHour;
  final String secondMin;
  final String thirdHour;
  final String thirdMin;

  const ScheduleSetting({
    super.key,
    required this.serialNumber,
    required this.onFirstDay,
    required this.onSecondDay,
    required this.onThirdDay,
    required this.onFirstHour,
    required this.onSecondHour,
    required this.onThirdHour,
    required this.onFirstMinute,
    required this.onSecondMinute,
    required this.onThirdMinute,
    required this.firstDay,
    required this.secondDay,
    required this.thirdDay,
    required this.firstHour,
    required this.firstMin,
    required this.secondHour,
    required this.secondMin,
    required this.thirdHour,
    required this.thirdMin,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    bool isAllDay = firstDay == "ALL" && secondDay == "ALL" && thirdDay == "ALL" ? true : false;
    List<String> firstDays = Timer.day.where((d) => d != secondDay && d != thirdDay || d == "OFF").toList();
    List<String> secondDays = Timer.day.where((d) => d != firstDay && d != thirdDay || d == "OFF").toList();
    List<String> thirdDays = Timer.day.where((d) => d != firstDay && d != secondDay || d == "OFF").toList();
    TextStyle style = TextStyle(fontSize: isTablet ? 24 : 18, color: Colors.white70, fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.schedule, color: Colors.white70, size: isTablet ? 38 : 28),
            Text(
              " ตั้งค่าเวลาแจ้งรีพอร์ต",
              style: TextStyle(fontSize: isTablet ? 26 : 20, color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("วันที่", style: style),
            Row(
              children: [
                Text("ทุกวัน ", style: style),
                Switch(
                  value: isAllDay,
                  onChanged: (bool value) {
                    if (value) {
                      onFirstDay("ALL");
                      onSecondDay("ALL");
                      onThirdDay("ALL");
                    } else {
                      onFirstDay("MON");
                      onSecondDay("WED");
                      onThirdDay("FRI");
                    }
                  },
                  activeColor: Colors.green[800],
                  activeTrackColor: Colors.green[400],
                  inactiveThumbColor: Colors.grey[600],
                  inactiveTrackColor: Colors.white70,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("วันที่แรก", style: style),
                const SizedBox(height: 5),
                DropdownMenu(
                  enabled: !isAllDay,
                  initialSelection: firstDay,
                  width: isTablet ? 110 : 100,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onFirstDay(value!),
                  dropdownMenuEntries: firstDays.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 15 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("วันที่สอง", style: style),
                const SizedBox(height: 5),
                DropdownMenu(
                  enabled: !isAllDay,
                  initialSelection: secondDay,
                  width: isTablet ? 110 : 100,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onSecondDay(value!),
                  dropdownMenuEntries: secondDays.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 15 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("วันที่สาม", style: style),
                const SizedBox(height: 5),
                DropdownMenu(
                  enabled: !isAllDay,
                  initialSelection: thirdDay,
                  width: isTablet ? 110 : 100,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onThirdDay(value!),
                  dropdownMenuEntries: thirdDays.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isTablet ? 15 : 10),
        Text("เวลา", style: style),
        SizedBox(height: isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ช่วงเวลาที่หนึ่ง ", style: style),
            Row(
              children: [
                DropdownMenu(
                  initialSelection: firstHour,
                  width: isTablet ? 94 : 83,
                  menuHeight: MediaQuery.of(context).size.height * 0.5,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onFirstHour(value!),
                  dropdownMenuEntries: Timer.hour.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
                const Text(" : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                DropdownMenu(
                  initialSelection: firstMin,
                  width: isTablet ? 94 : 83,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onFirstMinute(value!),
                  dropdownMenuEntries: Timer.minute.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ช่วงเวลาที่สอง ", style: style),
            Row(
              children: [
                DropdownMenu(
                  initialSelection: secondHour,
                  width: isTablet ? 94 : 83,
                  menuHeight: MediaQuery.of(context).size.height * 0.5,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onSecondHour(value!),
                  dropdownMenuEntries: Timer.hour.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
                const Text(" : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                DropdownMenu(
                  initialSelection: secondMin,
                  width: isTablet ? 94 : 83,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onSecondMinute(value!),
                  dropdownMenuEntries: Timer.minute.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isTablet ? 15 : 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ช่วงเวลาที่สาม ", style: style),
            Row(
              children: [
                DropdownMenu(
                  initialSelection: thirdHour,
                  width: isTablet ? 94 : 83,
                  menuHeight: MediaQuery.of(context).size.height * 0.5,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onThirdHour(value!),
                  dropdownMenuEntries: Timer.hour.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
                const Text(" : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                DropdownMenu(
                  initialSelection: thirdMin,
                  width: isTablet ? 94 : 83,
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (String? value) => onThirdMinute(value!),
                  dropdownMenuEntries: Timer.minute.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
