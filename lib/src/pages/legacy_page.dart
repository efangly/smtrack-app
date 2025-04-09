import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/models/legacy_notification.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class LegacyPage extends StatefulWidget {
  const LegacyPage({super.key});

  @override
  State<LegacyPage> createState() => _LegacyPageState();
}

class _LegacyPageState extends State<LegacyPage> {
  final api = Api();
  Timer? _timer;
  Map<dynamic, dynamic> arguments = {};
  List<LegacyNotificationList> legacyList = [];
  bool isTablet = false;
  String sn = "";

  Future<void> getNotification(String sn) async {
    try {
      legacyList = await api.getLegacyNotification(sn);
      if (mounted) setState(() {});
    } on Exception {
      setState(() {
        ShowSnackbar.snackbar(ContentType.failure, "เกิดข้อผิดพลาด", "ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้");
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      getNotification(sn);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    getNotification(arguments['serial']);
    sn = arguments['serial'];
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      arguments['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isTablet ? 24 : 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async => await getNotification(arguments['serial']),
                icon: Icon(Icons.refresh, size: isTablet ? 40 : 30, color: Colors.white60),
              ),
            ],
          ),
        ),
      ),
      body: Container(
          decoration: ConstColor.bgColor,
          child: ListView.separated(
            itemCount: legacyList.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.white12,
              height: 4,
              indent: 15,
              endIndent: 15,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  legacyList[index].message ?? "- -",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: isTablet ? 22 : 16,
                  ),
                ),
                tileColor: const Color.fromARGB(255, 165, 190, 202),
                subtitle: Text(legacyList[index].probe ?? "- -", style: TextStyle(fontSize: isTablet ? 20 : 14)),
              );
            },
          )),
    );
  }
}
