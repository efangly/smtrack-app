import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/api.dart';
import 'package:temp_noti/src/widgets/setting/noti_setting.dart';
import 'package:temp_noti/src/widgets/setting/schedule_setting.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class ProbeAdj extends StatefulWidget {
  final Probe probe;
  final bool isTablet;
  const ProbeAdj({super.key, required this.probe, required this.isTablet});

  @override
  State<ProbeAdj> createState() => _ProbeAdjState();
}

class _ProbeAdjState extends State<ProbeAdj> {
  final api = Api();
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

  @override
  void initState() {
    super.initState();
    normalMsg = widget.probe.notiToNormal;
    notificationMsg = widget.probe.notiMobile;
    firstMsgDelay = widget.probe.notiDelay.toString();
    repeat = widget.probe.notiRepeat.toString();
    firstDay = widget.probe.firstDay;
    secondDay = widget.probe.secondDay;
    thirdDay = widget.probe.thirdDay;
    firstHour = widget.probe.firstTime!.substring(0, 2);
    firstMin = widget.probe.firstTime!.substring(2);
    secondHour = widget.probe.secondTime!.substring(0, 2);
    secondMin = widget.probe.secondTime!.substring(2);
    thirdHour = widget.probe.thirdTime!.substring(0, 2);
    thirdMin = widget.probe.thirdTime!.substring(2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(decoration: ConstColor.bgColor),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 8),
            child: SingleChildScrollView(
              child: BlocBuilder<DevicesBloc, DevicesState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      NotiSetting(
                        serialNumber: widget.probe.sn!,
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
                        serialNumber: widget.probe.sn!,
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
        Positioned(
          right: 8,
          top: 3,
          child: TextButton.icon(
            onPressed: () async {
              final payload = Probe(
                notiToNormal: normalMsg,
                notiMobile: notificationMsg,
                notiDelay: int.parse(firstMsgDelay!),
                notiRepeat: int.parse(repeat!),
                firstDay: firstDay,
                secondDay: secondDay,
                thirdDay: thirdDay,
                firstTime: "$firstHour$firstMin",
                secondTime: "$secondHour$secondMin",
                thirdTime: "$thirdHour$thirdMin",
              );
              try {
                final result = await api.updateProbe(widget.probe.id!, payload);
                if (result) {
                  if (context.mounted) ShowSnackbar.snackbar(ContentType.success, "บันทึกข้อมูลสำเร็จ", "บันทึกข้อมูลสำเร็จ");
                }
              } on Exception catch (e) {
                if (kDebugMode) print(e);
                if (context.mounted) ShowSnackbar.snackbar(ContentType.failure, "เกิดข้อผิดพลาด", "ไม่สามารถบันทึกข้อมูลได้");
              }
            },
            label: Text(
              "บันทึก",
              style: TextStyle(
                fontSize: widget.isTablet ? 20 : 16,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: FaIcon(
              FontAwesomeIcons.floppyDisk,
              size: widget.isTablet ? 30 : 24,
              color: Colors.white70,
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: widget.isTablet ? 20 : 12, vertical: widget.isTablet ? 10 : 5),
            ),
          ),
        )
      ],
    );
  }
}
