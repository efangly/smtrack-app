import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class ConfigBtn extends StatefulWidget {
  final String serial;
  final bool isTablet;
  const ConfigBtn({super.key, required this.serial, required this.isTablet});

  @override
  State<ConfigBtn> createState() => _ConfigBtnState();
}

class _ConfigBtnState extends State<ConfigBtn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state.role == "USER" || state.role == "GUEST") {
          return const SizedBox();
        } else {
          return IconButton(
            onPressed: () {
              Navigator.pushNamed(context, custom_route.Route.config, arguments: {'serial': widget.serial});
            },
            icon: Icon(Icons.settings, size: widget.isTablet ? 40 : 30, color: Colors.white60),
          );
        }
      },
    );
  }
}
