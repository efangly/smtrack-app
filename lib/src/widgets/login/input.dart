import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;

  const InputForm({super.key, required this.username, required this.password});

  final _color = Colors.black54;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle() => TextStyle(fontWeight: FontWeight.w500, color: _color);
    return Form(
      child: Column(
        children: [
          TextField(
            controller: username,
            maxLength: 30,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: textStyle(),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
            ),
            style: TextStyle(color: _color),
          ),
          const Divider(height: 22, thickness: 1, indent: 10, endIndent: 10),
          TextField(
            controller: password,
            maxLength: 15,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: textStyle(),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
            ),
            style: TextStyle(color: _color),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
