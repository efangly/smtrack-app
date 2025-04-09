import 'package:flutter/material.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class ManuBar extends StatelessWidget {
  const ManuBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.all(12.0),
          icon: Icon(Icons.notifications, size: isTablet ? 45 : 30),
          onPressed: () => Navigator.pushNamed(context, custom_route.Route.notification),
        ),
        IconButton(
          padding: const EdgeInsets.all(12.0),
          icon: Icon(Icons.settings, size: isTablet ? 45 : 30),
          onPressed: () => Navigator.pushNamed(context, custom_route.Route.setting),
        ),
      ],
    );
  }
}
