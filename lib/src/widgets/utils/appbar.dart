import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.titleInfo});
  final Widget titleInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ConstColor.bodyAColor, ConstColor.bodyBColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
        ),
      ),
      child: SafeArea(child: titleInfo),
    );
  }
}
