import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/notification/notification_tab.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.isTablet ? 80 : 70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: Responsive.isTablet ? 40 : 30, color: Colors.white60),
              ),
              Text(
                "แจ้งเตือน",
                style: TextStyle(fontSize: Responsive.isTablet ? 24 : 20, fontWeight: FontWeight.w900),
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, custom_route.Route.notisetting),
                icon: Icon(Icons.settings, size: Responsive.isTablet ? 40 : 30, color: Colors.white60),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) => NotificationTab(hospital: state.hospital, role: state.role, isTablet: Responsive.isTablet),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
