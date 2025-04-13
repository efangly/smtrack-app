import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/widgets/legacy/legacy_list.dart';
import 'package:temp_noti/src/widgets/legacy/legacy_title.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';

class LegacyPage extends StatefulWidget {
  const LegacyPage({super.key});

  @override
  State<LegacyPage> createState() => _LegacyPageState();
}

class _LegacyPageState extends State<LegacyPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.isTablet ? 80 : 70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: Responsive.isTablet ? 40 : 30, color: Colors.white60),
              ),
              LegacyTitle(title: arguments['name'], isTablet: Responsive.isTablet),
              const SizedBox(width: 35),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        child: LegacyList(sn: arguments['serial'], isTablet: Responsive.isTablet),
      ),
    );
  }
}
