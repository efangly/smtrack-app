import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController displayController;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();
  bool isSubmit = false;

  String? checkEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void initState() {
    displayController = TextEditingController();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    displayController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    TextStyle labelStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: isTablet ? 20 : 16, color: Colors.white70);

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
              Text('Account', style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900)),
              const SizedBox(width: 35),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(decoration: ConstColor.bgColor),
          Container(
            margin: const EdgeInsets.all(10.0),
            width: 600,
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                displayController.text = state.displayName;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.userGroup, size: isTablet ? 38 : 28, color: Colors.white70),
                        const SizedBox(width: 8),
                        Text(
                          "Display Name",
                          style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                      ],
                    ),
                    TextField(
                      controller: displayController,
                      maxLength: 50,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: isTablet ? 26 : 20, fontWeight: FontWeight.w500, color: Colors.white70),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 8, top: 15),
                        helperStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (isSubmit) return;
                            if (displayController.text != "") {
                              isSubmit = true;
                              UserData user = UserData(displayName: displayController.text);
                              try {
                                bool? response = await Api.updateUser(state.userId, user);
                                if (response && context.mounted) {
                                  context.read<UsersBloc>().add(SetUser(displayController.text, state.userPic, state.role, state.userId));
                                  isSubmit = false;
                                  UtilsApp.showSnackBar(context, ContentType.success, "Success", "Display name updated");
                                }
                              } catch (e) {
                                if (kDebugMode) print(e.toString());
                                if (context.mounted) UtilsApp.pushToLogin(context);
                              }
                            } else {
                              if (context.mounted) UtilsApp.showSnackBar(context, ContentType.failure, "Error", "Please enter some text");
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.pencil, size: isTablet ? 38 : 28, color: Colors.white70),
                        ),
                      ),
                    ),
                    SizedBox(height: isTablet ? 20 : 10),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.userLock, size: isTablet ? 38 : 28, color: Colors.white70),
                        const SizedBox(width: 8),
                        Text(
                          "Change Password",
                          style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: oldPasswordController,
                            maxLength: 16,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            validator: checkEmpty,
                            style: TextStyle(fontSize: isTablet ? 26 : 20, fontWeight: FontWeight.w500, color: Colors.white70),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: labelStyle,
                              contentPadding: const EdgeInsets.only(left: 8, top: 15),
                              helperStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                            ),
                          ),
                          TextFormField(
                            controller: newPasswordController,
                            maxLength: 16,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            validator: checkEmpty,
                            style: TextStyle(fontSize: isTablet ? 26 : 20, fontWeight: FontWeight.w500, color: Colors.white70),
                            decoration: InputDecoration(
                              labelText: "New password",
                              labelStyle: labelStyle,
                              contentPadding: const EdgeInsets.only(left: 8, top: 15),
                              helperStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                            ),
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            maxLength: 16,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            validator: checkEmpty,
                            style: TextStyle(fontSize: isTablet ? 26 : 20, fontWeight: FontWeight.w500, color: Colors.white70),
                            decoration: InputDecoration(
                              labelText: "Confirm password",
                              labelStyle: labelStyle,
                              contentPadding: const EdgeInsets.only(left: 8, top: 15),
                              helperStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  if (isSubmit) return;
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      if (newPasswordController.text != confirmPasswordController.text) {
                                        if (context.mounted) {
                                          UtilsApp.showSnackBar(context, ContentType.failure, "Error", "Password not match");
                                        }
                                        return;
                                      }
                                      isSubmit = true;
                                      ChangePassword changePassword = ChangePassword(
                                        oldPassword: oldPasswordController.text,
                                        password: newPasswordController.text,
                                      );
                                      final response = await Api.changPass(state.userId, changePassword);
                                      if (response && context.mounted) {
                                        isSubmit = false;
                                        oldPasswordController.clear();
                                        newPasswordController.clear();
                                        confirmPasswordController.clear();
                                        formKey.currentState!.reset();
                                        UtilsApp.showSnackBar(context, ContentType.success, "Success", "Password changed");
                                      }
                                    } catch (e) {
                                      isSubmit = false;
                                      if (kDebugMode) print(e.toString());
                                      if (e is DioException) {
                                        if (context.mounted) {
                                          if (e.response!.statusCode == 401) {
                                            if (context.mounted) UtilsApp.pushToLogin(context);
                                          } else {
                                            UtilsApp.showSnackBar(context, ContentType.failure, "Error", "Incorrect password");
                                          }
                                        }
                                      }
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(color: Colors.white70),
                                    ),
                                  ),
                                ),
                                label: Text(
                                  "Change",
                                  style: TextStyle(fontSize: isTablet ? 24 : 18, color: Colors.white70, fontWeight: FontWeight.bold),
                                ),
                                icon: FaIcon(FontAwesomeIcons.key, size: isTablet ? 38 : 28, color: Colors.white70),
                              ),
                              SizedBox(width: isTablet ? 30 : 20),
                              TextButton.icon(
                                onPressed: () => formKey.currentState!.reset(),
                                label: Text(
                                  "Clear",
                                  style: TextStyle(fontSize: isTablet ? 24 : 18, color: Colors.white70, fontWeight: FontWeight.bold),
                                ),
                                icon: FaIcon(FontAwesomeIcons.trash, size: isTablet ? 38 : 28, color: Colors.white70),
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(color: Colors.white70),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white30, height: 80),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Remove account', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
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
                                  child: const Text('Remove', style: TextStyle(color: Color.fromARGB(255, 255, 17, 0))),
                                  onPressed: () async {
                                    try {
                                      await Api.deleteUser(state.userId);
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
                                    } on Exception catch (e) {
                                      if (kDebugMode) print(e.toString());
                                      if (context.mounted) {
                                        UtilsApp.showSnackBar(context, ContentType.failure, "Error", "Failed to remove account");
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      label: Text(
                        'Remove account',
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[500],
                        ),
                      ),
                      icon: Icon(Icons.delete_forever, size: isTablet ? 40 : 30, color: Colors.red[500]),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
