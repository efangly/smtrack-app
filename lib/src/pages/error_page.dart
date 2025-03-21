import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_noti/firebase_options.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/login/header.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  Future<String> init() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      await warning("No internet connection", "Please connect to the internet");
      return "/error";
    }
    HttpOverrides.global = PostHttpOverrides();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseApi().initNotifications();
    FirebaseMessaging.onBackgroundMessage(FirebaseApi.messagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(FirebaseApi.messagingHandler);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token == null ? "/login" : "/";
  }

  Future<void> warning(String title, String data) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.white70)),
          content: Text(data, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 0, 77, 192),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white60),
              child: const Text('OK', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ConstColor.bgColor,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header(),
              const Text(
                "Unable to connect internet",
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () async {
                  String route = await init();
                  setState(() {
                    switch (route) {
                      case "/error":
                        break;
                      case "/login":
                        SharedPreferences.getInstance().then((prefs) => prefs.clear());
                        Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.login, (route) => false);
                        break;
                      default:
                        Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.home, (route) => false);
                        break;
                    }
                  });
                },
                icon: const Icon(Icons.refresh, color: Colors.white, size: 25),
                label: const Text('Retry', style: TextStyle(color: Colors.white, fontSize: 18)),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.red[400],
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
