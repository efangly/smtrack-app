import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:temp_noti/src/app.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/services/services.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  String route = await UtilsApp.init();
  final deviceBloc = BlocProvider<DevicesBloc>(create: (context) => DevicesBloc());
  final notificationBloc = BlocProvider<NotificationsBloc>(create: (context) => NotificationsBloc());
  final userBloc = BlocProvider<UsersBloc>(create: (context) => UsersBloc());
  FlutterNativeSplash.remove();

  runApp(MultiBlocProvider(
    providers: [deviceBloc, notificationBloc, userBloc],
    child: App(route: route),
  ));
}
