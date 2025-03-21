import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/models/devices.dart';

class SubtitleList extends StatelessWidget {
  const SubtitleList({super.key, this.deviceInfo});
  final DeviceList? deviceInfo;

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    IconData batteryIcon = deviceInfo!.log!.isEmpty
        ? FontAwesomeIcons.batteryEmpty
        : deviceInfo!.log![0].battery! > 75
            ? FontAwesomeIcons.batteryFull
            : deviceInfo!.log![0].battery! > 50
                ? FontAwesomeIcons.batteryThreeQuarters
                : deviceInfo!.log![0].battery! > 25
                    ? FontAwesomeIcons.batteryHalf
                    : FontAwesomeIcons.batteryQuarter;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          deviceInfo!.devSerial ?? "-",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isTablet ? 18 : 12,
          ),
        ),
        Text(
          deviceInfo!.locInstall ?? "-",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isTablet ? 18 : 12,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.temperatureHigh, size: isTablet ? 22 : 16),
            const SizedBox(width: 2),
            Text(
              deviceInfo!.noti!.where((i) => i.notiDetail!.substring(0, 4) == "TEMP").toList().length.toString(),
              style: TextStyle(fontSize: isTablet ? 20 : 14),
            ),
            const SizedBox(width: 5),
            FaIcon(FontAwesomeIcons.doorOpen, size: isTablet ? 22 : 16),
            const SizedBox(width: 2),
            Text(
              deviceInfo!.noti!
                  .where((i) => i.notiDetail!.substring(0, 5) == "PROBE" && i.notiDetail!.substring(13, 15) == "ON")
                  .toList()
                  .length
                  .toString(),
              style: TextStyle(fontSize: isTablet ? 20 : 14),
            ),
            const SizedBox(width: 5),
            FaIcon(FontAwesomeIcons.plug, size: isTablet ? 22 : 16),
            const SizedBox(width: 2),
            Text(
              deviceInfo!.noti!.where((i) => i.notiDetail!.substring(0, 2) == "AC").toList().length.toString(),
              style: TextStyle(fontSize: isTablet ? 20 : 14),
            ),
            const SizedBox(width: 5),
            FaIcon(FontAwesomeIcons.sdCard, size: isTablet ? 22 : 16),
            const SizedBox(width: 2),
            Text(
              deviceInfo!.noti!.where((i) => i.notiDetail!.substring(0, 2) == "SD").toList().length.toString(),
              style: TextStyle(fontSize: isTablet ? 20 : 14),
            ),
            const SizedBox(width: 5),
            FaIcon(FontAwesomeIcons.wifi, size: isTablet ? 22 : 16),
            const SizedBox(width: 2),
            Text(
              deviceInfo!.cCount!.log.toString(),
              style: TextStyle(fontSize: isTablet ? 20 : 14),
            ),
            const SizedBox(width: 5),
            FaIcon(batteryIcon, size: isTablet ? 22 : 16),
            const SizedBox(width: 2),
            Text(
              deviceInfo!.log!.isEmpty ? "0" : "${deviceInfo!.log![0].battery}",
              style: TextStyle(fontSize: isTablet ? 20 : 14),
            ),
          ],
        ),
      ],
    );
  }
}
