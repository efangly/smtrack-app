import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController displayNameController;
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
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    displayNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    displayNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 30.0, color: Colors.white60),
              ),
              const Text(
                "Register",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(decoration: ConstColor.bgColor),
          Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            child: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white70,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Create your account",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: usernameController,
                                maxLength: 40,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54),
                                validator: checkEmpty,
                                decoration: const InputDecoration(
                                  labelText: "Username",
                                  labelStyle: TextStyle(color: Colors.black54),
                                  helperStyle: TextStyle(color: Colors.black54),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: passwordController,
                                maxLength: 16,
                                obscureText: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54),
                                validator: checkEmpty,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.black54),
                                  helperStyle: TextStyle(color: Colors.black54),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: displayNameController,
                                maxLength: 50,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54),
                                validator: checkEmpty,
                                decoration: const InputDecoration(
                                  labelText: "Display Name",
                                  labelStyle: TextStyle(color: Colors.black54),
                                  helperStyle: TextStyle(color: Colors.black54),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                                ),
                              ),
                              const Divider(height: 30, color: Colors.black45),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    onPressed: isSubmit
                                        ? null
                                        : () async {
                                            if (formKey.currentState!.validate()) {
                                              try {
                                                isSubmit = true;
                                                final response = await Api.register(
                                                  usernameController.text,
                                                  passwordController.text,
                                                  displayNameController.text,
                                                );
                                                if (response) {
                                                  isSubmit = false;
                                                  usernameController.clear();
                                                  passwordController.clear();
                                                  displayNameController.clear();
                                                  formKey.currentState!.reset();
                                                  if (context.mounted) {
                                                    UtilsApp.showSnackBar(
                                                      context,
                                                      ContentType.success,
                                                      "Success",
                                                      "Register Success",
                                                    );
                                                  }
                                                  await Future.delayed(const Duration(seconds: 2));
                                                  if (context.mounted) Navigator.pop(context);
                                                } else {
                                                  setState(() {
                                                    isSubmit = false;
                                                    UtilsApp.showSnackBar(
                                                      context,
                                                      ContentType.failure,
                                                      "Error",
                                                      "Failed to create account",
                                                    );
                                                  });
                                                }
                                              } catch (e) {
                                                setState(() {
                                                  isSubmit = false;
                                                  UtilsApp.showSnackBar(
                                                    context,
                                                    ContentType.failure,
                                                    "Error",
                                                    "Failed to create account",
                                                  );
                                                });
                                              }
                                            }
                                          },
                                    label: const Text("Submit", style: TextStyle(color: Colors.black54)),
                                    icon: const Icon(Icons.save, color: Colors.black54),
                                    style: TextButton.styleFrom(fixedSize: const Size.fromWidth(150)),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      usernameController.clear();
                                      passwordController.clear();
                                      displayNameController.clear();
                                      formKey.currentState!.reset();
                                    },
                                    label: const Text("Clear", style: TextStyle(color: Colors.black54)),
                                    icon: const Icon(Icons.refresh, color: Colors.black54),
                                    style: TextButton.styleFrom(fixedSize: const Size.fromWidth(150)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
