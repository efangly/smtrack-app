import 'package:flutter/material.dart';

class ConstColor {
  static const appBarColor = Color.fromARGB(255, 51, 136, 255);
  static const bodyAColor = Color.fromARGB(255, 48, 190, 255);
  static const bodyBColor = Color.fromARGB(255, 0, 77, 192);
  static const bgColor = BoxDecoration(
    gradient: LinearGradient(
      colors: [bodyAColor, bodyBColor],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [0.0, 1.0],
    ),
  );
}
