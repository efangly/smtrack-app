import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70, bottom: 30),
      child: Image.asset('assets/images/logo.png', height: 180, scale: 0.7),
    );
  }
}
