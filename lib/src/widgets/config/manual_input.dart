import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManualNework extends StatelessWidget {
  final TextEditingController ipController;
  final TextEditingController subnetController;
  final TextEditingController gatewayController;
  final TextEditingController dnsController;
  final bool isEnable;
  const ManualNework({
    super.key,
    required this.ipController,
    required this.subnetController,
    required this.gatewayController,
    required this.dnsController,
    required this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    Color? fontColor(bool active) => active ? Colors.white70 : Colors.grey[600];
    return Column(
      children: [
        const SizedBox(height: 10),
        TextField(
          enabled: isEnable,
          controller: ipController,
          maxLength: 15,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'IP Address',
            labelStyle: TextStyle(fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.w500, color: fontColor(isEnable)),
            helperStyle: TextStyle(fontSize: 10, color: fontColor(isEnable)),
            contentPadding: const EdgeInsets.only(left: 8, top: 10),
            icon: FaIcon(FontAwesomeIcons.addressCard, size: 30, color: fontColor(isEnable)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          enabled: isEnable,
          controller: subnetController,
          maxLength: 15,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Subnet',
            labelStyle: TextStyle(fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.w500, color: fontColor(isEnable)),
            helperStyle: TextStyle(fontSize: 10, color: fontColor(isEnable)),
            contentPadding: const EdgeInsets.only(left: 4, top: 10),
            icon: FaIcon(FontAwesomeIcons.networkWired, size: 30, color: fontColor(isEnable)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          enabled: isEnable,
          controller: gatewayController,
          maxLength: 15,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'Gateway',
            labelStyle: TextStyle(fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.w500, color: fontColor(isEnable)),
            helperStyle: TextStyle(fontSize: 10, color: fontColor(isEnable)),
            contentPadding: const EdgeInsets.only(left: 12, top: 10),
            icon: FaIcon(FontAwesomeIcons.getPocket, size: 30, color: fontColor(isEnable)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          enabled: isEnable,
          controller: dnsController,
          maxLength: 15,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: 'DNS',
            labelStyle: TextStyle(fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.w500, color: fontColor(isEnable)),
            helperStyle: TextStyle(fontSize: 10, color: fontColor(isEnable)),
            contentPadding: const EdgeInsets.only(left: 10, top: 10),
            icon: FaIcon(FontAwesomeIcons.server, size: 30, color: fontColor(isEnable)),
          ),
        ),
      ],
    );
  }
}
