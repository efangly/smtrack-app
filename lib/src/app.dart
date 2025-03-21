import 'package:flutter/material.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/constants/style.dart';

class App extends StatelessWidget {
  const App({super.key, required this.route});
  final String? route;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: route,
      routes: custom_route.Route.getAll(),
      title: 'SMTrack+',
      theme: ThemeData(
        fontFamily: 'Anuphan',
        inputDecorationTheme: ThemeDataStyle.inputDecorationStyle,
        textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.blue),
        textTheme: ThemeDataStyle.textThemeStyle,
        iconTheme: const IconThemeData(color: Colors.white70),
        listTileTheme: const ListTileThemeData(textColor: Colors.white70, iconColor: Colors.white70),
        colorScheme: Theme.of(context).colorScheme.copyWith(outline: Colors.white30),
      ),
    );
  }
}
