import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_noti/firebase_options.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class UtilsApp {
  static Future<String> init() async {
    try {
      List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) return "/error";
      HttpOverrides.global = PostHttpOverrides();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await FirebaseApi().initNotifications();
      FirebaseMessaging.onBackgroundMessage(FirebaseApi.messagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen(FirebaseApi.messagingHandler);
      String? token = prefs.getString('token');
      if (token == null) return "/login";
      UserData? user = await Api.getUser();
      if (user == null) {
        String? topic = prefs.getString('topic');
        if (topic != null) FirebaseApi().unSubscribeTopic(topic);
        prefs.clear();
        return "/login";
      } else {
        return "/";
      }
    } on DioException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return "/login";
    }
  }

  static void pushToLogin(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Expire..', style: TextStyle(color: Colors.white70)),
          content: const Text('Login expired', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 0, 77, 192),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white60),
              child: const Text('OK', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? topic = prefs.getString('topic');
                if (topic != null) await FirebaseApi().unSubscribeTopic(topic);
                await prefs.clear();
                if (context.mounted) {
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

  static void showSnackBar(BuildContext context, ContentType type, String title, String message) {
    SnackBar snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
