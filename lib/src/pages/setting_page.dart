import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/utils/preference.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final configStorage = ConfigStorage();
  bool _isLoggingOut = false;
  Future<void> logout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ออกจากระบบ', style: TextStyle(color: Colors.white70)),
          content: const Text('คุณต้องการออกจากระบบ?', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 0, 77, 192),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white60),
              child: const Text('ยกเลิก', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white60),
              child: const Text('ออกจากระบบ', style: TextStyle(color: Color.fromARGB(255, 255, 17, 0))),
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() => _isLoggingOut = true);
                await configStorage.clearTokens();
                if (context.mounted) {
                  context.read<UsersBloc>().add(RemoveUser());
                  context.read<DevicesBloc>().add(ClearDevices());
                  setState(() => _isLoggingOut = false);
                  Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.login, (route) => false);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                  Text('ตั้งค่า', style: TextStyle(fontSize: Responsive.isTablet ? 24 : 20, fontWeight: FontWeight.w900)),
                  const SizedBox(width: 35),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(decoration: ConstColor.bgColor),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, custom_route.Route.user),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_box_rounded, size: Responsive.isTablet ? 36 : 26, color: Colors.white70),
                              const SizedBox(width: 8),
                              Text(
                                'บัญชีผู้ใช้',
                                style:
                                    TextStyle(fontSize: Responsive.isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, size: Responsive.isTablet ? 30 : 20, color: Colors.white70),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, custom_route.Route.privacy),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.privacy_tip_outlined, size: Responsive.isTablet ? 36 : 26, color: Colors.white70),
                              const SizedBox(width: 8),
                              Text(
                                'นโยบายความเป็นส่วนตัว',
                                style:
                                    TextStyle(fontSize: Responsive.isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, size: Responsive.isTablet ? 30 : 20, color: Colors.white70),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, custom_route.Route.condition),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline, size: Responsive.isTablet ? 36 : 26, color: Colors.white70),
                              const SizedBox(width: 8),
                              Text(
                                'ข้อกำหนดและเงื่อนไข',
                                style:
                                    TextStyle(fontSize: Responsive.isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, size: Responsive.isTablet ? 30 : 20, color: Colors.white70),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.isTablet ? 50 : 30),
                    TextButton(
                      onPressed: () => logout(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.logout_outlined, size: Responsive.isTablet ? 36 : 26, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text(
                                'ออกจากระบบ',
                                style:
                                    TextStyle(fontSize: Responsive.isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.red[600]),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios, size: Responsive.isTablet ? 30 : 20, color: Colors.red[600]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_isLoggingOut)
          Stack(
            children: [
              ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.3)),
              const Center(child: CircularProgressIndicator(color: Colors.white70)),
            ],
          ),
      ],
    );
  }
}
