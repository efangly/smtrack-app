import 'package:flutter/material.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class MenuList extends StatelessWidget {
  final bool isTablet;
  const MenuList({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
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
