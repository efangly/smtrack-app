import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_noti/src/services/services.dart';

class NotificationBtn extends StatefulWidget {
  const NotificationBtn({super.key});

  @override
  State<NotificationBtn> createState() => _NotificationBtnState();
}

class _NotificationBtnState extends State<NotificationBtn> {
  late SharedPreferences pref;
  bool noti = true;
  bool isDisable = false;

  Future<void> setNoti(bool value) async {
    isDisable = true;
    await pref.setBool('noti', value);
    if (value) {
      await FirebaseApi().subscribeTopic(pref.getString('topic')!);
      setState(() => noti = true);
    } else {
      await FirebaseApi().unSubscribeTopic(pref.getString('topic')!);
      setState(() => noti = false);
    }
    isDisable = false;
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      pref = value;
      noti = value.getBool('noti') ?? true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    return noti
        ? IconButton(
            onPressed: () async {
              isDisable ? null : await setNoti(false);
            },
            icon: Icon(Icons.notifications, size: isTablet ? 40 : 30, color: Colors.white60),
          )
        : IconButton(
            onPressed: () async {
              isDisable ? null : await setNoti(true);
            },
            icon: Icon(Icons.notifications_off, size: isTablet ? 40 : 30, color: Colors.white60),
          );
  }
}
