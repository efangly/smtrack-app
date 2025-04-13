import 'package:flutter/material.dart';

class LegacyTitle extends StatelessWidget {
  final String title;
  final bool isTablet;
  const LegacyTitle({super.key, required this.title, required this.isTablet});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
