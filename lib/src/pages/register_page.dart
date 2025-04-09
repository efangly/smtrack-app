import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Api api = Api();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController displayNameController;
  final formKey = GlobalKey<FormState>();
  bool isSubmit = false;

  String? checkEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'โปรดกรอกข้อมูลให้ครบถ้วน';
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
              const Text("ลงทะเบียน", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
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
                                "สร้างบัญชี",
                                style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: usernameController,
                                maxLength: 40,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54),
                                validator: checkEmpty,
                                decoration: const InputDecoration(
                                  labelText: "ชื่อผู้ใช้",
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
                                  labelText: "รหัสผ่าน",
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
                                  labelText: "ชื่อที่แสดง",
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
                                    onPressed: () async {
                                      if (isSubmit) return;
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          isSubmit = true;
                                          final response = await api.register(
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
                                              ShowSnackbar.snackbar(ContentType.success, "สำเร็จ", "ลงทะเบียนสำเร็จ");
                                            }
                                            await Future.delayed(const Duration(seconds: 2));
                                            if (context.mounted) Navigator.pop(context);
                                          } else {
                                            setState(() {
                                              isSubmit = false;
                                              ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถลงทะเบียนได้");
                                            });
                                          }
                                        } catch (e) {
                                          setState(() {
                                            isSubmit = false;
                                            ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถลงทะเบียนได้");
                                          });
                                        }
                                      }
                                    },
                                    label: const Text("สร้างบัญชี", style: TextStyle(color: Colors.black54)),
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
                                    label: const Text("ล้าง", style: TextStyle(color: Colors.black54)),
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
