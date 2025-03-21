import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/constants/style.dart';

class InputWifiInfo extends StatelessWidget {
  final TextEditingController ssid;
  final TextEditingController wifipassword;
  const InputWifiInfo({super.key, required this.ssid, required this.wifipassword});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    TextStyle labelStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: isTablet ? 20 : 16, color: Colors.white70);
    return Column(
      children: [
        TextField(
          controller: ssid,
          maxLength: 50,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'SSID',
            labelStyle: labelStyle,
            helperStyle: TextInputStyle.helperStyle,
            icon: FaIcon(
              FontAwesomeIcons.wifi,
              size: isTablet ? 40 : 30,
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: wifipassword,
          maxLength: 64,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Password',
            labelStyle: labelStyle,
            helperStyle: TextInputStyle.helperStyle,
            icon: FaIcon(FontAwesomeIcons.key, size: isTablet ? 40 : 30, color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
