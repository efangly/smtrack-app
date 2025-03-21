import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/login/input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late ScaffoldMessengerState snackbar;
  bool isLogin = false;
  Color gradientStart = const Color.fromARGB(255, 39, 101, 188);
  Color gradientEnd = const Color.fromARGB(255, 25, 175, 244);
  BoxShadow boxShadowItem(Color color) => BoxShadow(color: color, offset: const Offset(1.0, 6.0), blurRadius: 20.0);
  void submitLogin(Login value) {
    usernameController.clear();
    passwordController.clear();
    context.read<UsersBloc>().add(SetUser(value.data!.displayName ?? "-", value.data!.userPic ?? "/img/default-pic.png",
        value.data!.userLevel ?? "4", value.data!.userId ?? ""));
    Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.home, (route) => false);
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    snackbar = ScaffoldMessenger.of(context);
    void showMassage(String message) {
      snackbar.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Text(message),
            ],
          ),
          showCloseIcon: true,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 22, left: 15, right: 15),
          elevation: 5.0,
          color: Colors.white70,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox(
            width: 450,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 50),
              child: InputForm(username: usernameController, password: passwordController),
            ),
          ),
        ),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [boxShadowItem(gradientStart), boxShadowItem(gradientEnd)],
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: const [0.0, 1.0],
            ),
          ),
          child: TextButton.icon(
            onPressed: () async {
              if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                showMassage("Please fill in all fields");
                return;
              }
              if (isLogin) return;
              isLogin = true;
              snackbar.hideCurrentSnackBar();
              showMassage("Logging in...");
              await Api.checkLogin(usernameController.text, passwordController.text).then((value) {
                snackbar.hideCurrentSnackBar();
                showMassage("Login success");
                isLogin = false;
                snackbar.hideCurrentSnackBar();
                snackbar.clearSnackBars();
                submitLogin(value);
              }).catchError((err) {
                snackbar.hideCurrentSnackBar();
                showMassage("Unable to login");
                if (kDebugMode) print(err.toString());
              });
              isLogin = false;
              setState(() {});
            },
            icon: const FaIcon(FontAwesomeIcons.userCheck, size: 25.0, color: Colors.white60),
            label: const Text(
              'LOG IN',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
