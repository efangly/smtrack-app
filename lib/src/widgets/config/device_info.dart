import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/style.dart';

class DeviceInfo extends StatelessWidget {
  final TextEditingController deviceName;
  final TextEditingController devicePosition;
  final TextEditingController deviceLocation;
  const DeviceInfo({
    super.key,
    required this.deviceName,
    required this.devicePosition,
    required this.deviceLocation,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    TextStyle labelStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: isTablet ? 20 : 16, color: Colors.white70);
    return Column(
      children: [
        TextField(
          controller: deviceName,
          maxLength: 50,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Device Name',
            labelStyle: labelStyle,
            helperStyle: TextInputStyle.helperStyle,
            contentPadding: const EdgeInsets.only(left: 8, top: 10),
            icon: Icon(
              Icons.devices,
              size: isTablet ? 40 : 30,
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: devicePosition,
          maxLength: 150,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Device Position',
            labelStyle: labelStyle,
            helperStyle: TextInputStyle.helperStyle,
            contentPadding: const EdgeInsets.only(left: 4, top: 10),
            icon: Icon(Icons.location_on, size: isTablet ? 40 : 30, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: deviceLocation,
          maxLength: 150,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Device Location',
            labelStyle: labelStyle,
            helperStyle: TextInputStyle.helperStyle,
            contentPadding: const EdgeInsets.only(left: 8, top: 10),
            icon: Icon(
              Icons.location_city,
              size: isTablet ? 40 : 30,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
