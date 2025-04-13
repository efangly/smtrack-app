import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:temp_noti/firebase_options.dart';
import 'package:temp_noti/src/app.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/preference.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
  String route = "/";
  if (connectivityResult.contains(ConnectivityResult.none)) {
    route = "/error";
  } else {
    HttpOverrides.global = PostHttpOverrides();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    final firebaseApi = FirebaseApi();
    final configStorage = ConfigStorage();
    await firebaseApi.initNotifications();
    String? token = await configStorage.getAccessToken();
    if (token == null) {
      await configStorage.clearTokens();
      route = "/login";
    }
  }
  final deviceBloc = BlocProvider<DevicesBloc>(create: (context) => DevicesBloc());
  final notificationBloc = BlocProvider<NotificationsBloc>(create: (context) => NotificationsBloc());
  final userBloc = BlocProvider<UsersBloc>(create: (context) => UsersBloc());
  FlutterNativeSplash.remove();
  runApp(MultiBlocProvider(
    providers: [deviceBloc, notificationBloc, userBloc],
    child: App(route: route),
  ));
}
