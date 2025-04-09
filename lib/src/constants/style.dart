import 'package:flutter/material.dart';

class TextInputStyle {
  static const CircularProgressIndicator loading = CircularProgressIndicator(
    color: Colors.white70,
    backgroundColor: Color.fromARGB(255, 0, 94, 236),
    strokeWidth: 2,
  );
  static const inputStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );
  static InputDecorationTheme inputDecorationStyle = InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    constraints: BoxConstraints.tight(const Size.fromHeight(40)),
    border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    labelStyle: const TextStyle(color: Colors.white),
  );

  static TextStyle helperStyle = const TextStyle(color: Colors.white70, fontSize: 10);
  static TextStyle labelStyle = const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70);
}

class ThemeDataStyle {
  static const textThemeStyle = TextTheme(
    bodySmall: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white70),
    bodyLarge: TextStyle(color: Colors.white70),
    labelSmall: TextStyle(color: Colors.white70),
    labelMedium: TextStyle(color: Colors.white70),
    labelLarge: TextStyle(color: Colors.white70),
    displaySmall: TextStyle(color: Colors.white70),
    displayMedium: TextStyle(color: Colors.white70),
    displayLarge: TextStyle(color: Colors.white70),
  );
  static const inputDecorationStyle = InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.blue),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.solid, color: Colors.blue),
    ),
  );
}
