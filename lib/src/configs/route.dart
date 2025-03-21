import 'package:flutter/material.dart';
import 'package:temp_noti/src/pages/barcode_page.dart';
import 'package:temp_noti/src/pages/pages.dart';

class Route {
  static const home = '/';
  static const detail = '/detail';
  static const login = '/login';
  static const notification = '/notification';
  static const config = '/config';
  static const register = '/register';
  static const setup = '/setup';
  static const barcode = '/barcode';
  static const setting = '/setting';
  static const privacy = '/privacy';
  static const condition = '/condition';
  static const user = '/user';
  static const error = '/error';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    detail: (context) => const DetailPage(),
    notification: (context) => const NotificationPage(),
    config: (context) => const ConfigPage(),
    register: (context) => const RegisterPage(),
    setup: (context) => const SetupPage(),
    barcode: (context) => const BarcodePage(),
    setting: (context) => const SettingPage(),
    privacy: (context) => const PrivacyPage(),
    condition: (context) => const ConditionPage(),
    user: (context) => const UserPage(),
    error: (context) => const ErrorPage(),
  };
}
