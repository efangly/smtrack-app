import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    Future<void> logout() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout', style: TextStyle(color: Colors.white70)),
            content: const Text('Are you sure?', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 0, 77, 192),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white60),
                child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white60),
                child: const Text('Logout', style: TextStyle(color: Color.fromARGB(255, 255, 17, 0))),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? topic = prefs.getString('topic');
                  if (topic != null) await FirebaseApi().unSubscribeTopic(topic);
                  await prefs.clear();
                  if (context.mounted) {
                    context.read<DevicesBloc>().add(ClearDevices());
                    context.read<UsersBloc>().add(RemoveUser());
                    Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.login, (route) => false);
                  }
                },
              ),
            ],
          );
        },
      );
    }

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
              Text('Setting', style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900)),
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
                          Icon(Icons.account_box_rounded, size: isTablet ? 36 : 26, color: Colors.white70),
                          const SizedBox(width: 8),
                          Text(
                            'Account',
                            style: TextStyle(fontSize: isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: isTablet ? 30 : 20, color: Colors.white70),
                    ],
                  ),
                ),
                BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state.role == '0' || state.role == '1') {
                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, custom_route.Route.config),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.devices, size: isTablet ? 36 : 26, color: Colors.white70),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Setup devices',
                                      style: TextStyle(fontSize: isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios, size: isTablet ? 30 : 20, color: Colors.white70),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox(height: 0);
                    }
                  },
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, custom_route.Route.privacy),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.privacy_tip_outlined, size: isTablet ? 36 : 26, color: Colors.white70),
                          const SizedBox(width: 8),
                          Text(
                            'Privacy policy',
                            style: TextStyle(fontSize: isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: isTablet ? 30 : 20, color: Colors.white70),
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
                          Icon(Icons.info_outline, size: isTablet ? 36 : 26, color: Colors.white70),
                          const SizedBox(width: 8),
                          Text(
                            'Term & condition',
                            style: TextStyle(fontSize: isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: isTablet ? 30 : 20, color: Colors.white70),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 50 : 30),
                TextButton(
                  onPressed: () => logout(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout_outlined, size: isTablet ? 36 : 26, color: Colors.red[600]),
                          const SizedBox(width: 8),
                          Text(
                            'Log out',
                            style: TextStyle(fontSize: isTablet ? 24 : 18, fontWeight: FontWeight.bold, color: Colors.red[600]),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, size: isTablet ? 30 : 20, color: Colors.red[600]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
