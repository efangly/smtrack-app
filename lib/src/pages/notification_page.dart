import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/notification/notification_tab.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
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
              Text(
                "แจ้งเตือน",
                style: TextStyle(fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.w900),
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, custom_route.Route.notisetting),
                icon: Icon(Icons.settings, size: isTablet ? 40 : 30, color: Colors.white60),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) => NotificationTab(hospital: state.hospital, role: state.role, isTablet: isTablet),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
