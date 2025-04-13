import 'package:flutter/material.dart';

class Responsive {
  static late bool isTablet;

  static void init(BuildContext context) {
    final mq = MediaQuery.of(context);
    isTablet = mq.size.width > 700 ? true : false;
  }
}
