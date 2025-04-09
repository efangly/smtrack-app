import 'package:flutter/material.dart';
import 'package:temp_noti/src/pages/noti_setting_page.dart';
import 'package:temp_noti/src/pages/pages.dart';

class Route {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static const home = '/';
  static const device = '/device';
  static const login = '/login';
  static const notification = '/notification';
  static const register = '/register';
  static const config = '/config';
  static const notisetting = '/notisetting';
  static const setting = '/setting';
  static const privacy = '/privacy';
  static const condition = '/condition';
  static const user = '/user';
  static const legacy = '/legacy';
  static const error = '/error';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    device: (context) => const DevicePage(),
    notification: (context) => const NotificationPage(),
    register: (context) => const RegisterPage(),
    config: (context) => const ConfigPage(),
    notisetting: (context) => const NotiSettingPage(),
    setting: (context) => const SettingPage(),
    privacy: (context) => const PrivacyPage(),
    condition: (context) => const ConditionPage(),
    user: (context) => const UserPage(),
    legacy: (context) => const LegacyPage(),
    error: (context) => const ErrorPage(),
  };
}
