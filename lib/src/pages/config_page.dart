import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/widgets/config/input.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isTablet ? 80 : 70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: isTablet ? 40 : 30, color: Colors.white60),
              ),
              Text(
                "Setup Devices",
                style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 3, left: 3),
                child: SizedBox(width: 30),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(decoration: ConstColor.bgColor),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: const InputConfig(),
          ),
        ],
      ),
    );
  }
}
