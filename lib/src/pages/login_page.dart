import 'package:flutter/material.dart';
import 'package:temp_noti/src/configs/version.dart';
import 'package:temp_noti/src/widgets/login/header.dart';
import 'package:temp_noti/src/widgets/login/login_form.dart';
import 'package:temp_noti/src/widgets/login/signup_btn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 0, 77, 192), Color.fromARGB(255, 255, 255, 255)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 1.0],
              ),
            ),
          ),
          const SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                LoginForm(),
                SizedBox(height: 15),
                SizedBox(
                  height: 20,
                  width: 450,
                  child: Divider(height: 22, thickness: 2, indent: 20, endIndent: 20, color: Colors.white38),
                ),
                SizedBox(height: 15),
                SignupButton(),
                SizedBox(height: 15),
                Text('Version: ${Versions.version}', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
