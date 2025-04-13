import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/login/input.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Api api = Api();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  String loginBtnText = "ลงชื่อเข้าใช้";
  bool isLogin = false;

  void submitLogin() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "โปรดกรอกข้อมูลให้ครบถ้วน");
      return;
    }
    if (isLogin) return;
    isLogin = true;
    setState(() => loginBtnText = "กำลังเข้าสู่ระบบ");
    try {
      await api.checkLogin(usernameController.text, passwordController.text);
      isLogin = false;
      setState(() {
        loginBtnText = "ลงชื่อเข้าใช้";
        usernameController.clear();
        passwordController.clear();
        Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.home, (route) => false);
      });
    } on Exception catch (e) {
      setState(() {
        ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", e.toString());
        loginBtnText = "ลงชื่อเข้าใช้";
        isLogin = false;
      });
    }
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
          width: 200,
          height: 55,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(color: Color.fromARGB(255, 39, 101, 188), offset: Offset(1.0, 6.0), blurRadius: 20.0),
              BoxShadow(color: Color.fromARGB(255, 25, 175, 244), offset: Offset(1.0, 6.0), blurRadius: 20.0),
            ],
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 39, 101, 188), Color.fromARGB(255, 25, 175, 244)],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
            ),
          ),
          child: TextButton.icon(
            onPressed: () async => submitLogin(),
            icon: isLogin
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: TextInputStyle.loading,
                  )
                : const FaIcon(
                    FontAwesomeIcons.userCheck,
                    size: 25.0,
                    color: Colors.white60,
                  ),
            label: Text(
              loginBtnText,
              style: TextStyle(color: isLogin ? Colors.white54 : Colors.white70, fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
