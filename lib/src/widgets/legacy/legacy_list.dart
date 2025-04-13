import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/models/legacy_notification.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class LegacyList extends StatefulWidget {
  final String sn;
  final bool isTablet;
  const LegacyList({super.key, required this.sn, required this.isTablet});

  @override
  State<LegacyList> createState() => _LegacyListState();
}

class _LegacyListState extends State<LegacyList> {
  final api = Api();
  Timer? _timer;
  List<LegacyNotificationList> legacyList = [];

  Future<void> getNotification() async {
    try {
      legacyList = await api.getLegacyNotification(widget.sn);
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
    getNotification();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      getNotification();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (legacyList.isEmpty) {
      return const Center(child: Text("ไม่พบการแจ้งเตือน", style: TextStyle(color: Colors.white70, fontSize: 20)));
    }
    return ListView.separated(
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
              fontSize: widget.isTablet ? 22 : 16,
            ),
          ),
          tileColor: const Color.fromARGB(255, 165, 190, 202),
          subtitle: Text(legacyList[index].probe ?? "- -", style: TextStyle(fontSize: widget.isTablet ? 20 : 14)),
        );
      },
    );
  }
}
