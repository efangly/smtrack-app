import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/notification/notifications_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/models/users.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/home/filter.dart';
import 'package:temp_noti/src/widgets/home/menu.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/home/machine_list.dart';
import 'package:temp_noti/src/widgets/home/title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirst = false;
    Widget expiredToken() {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Expired token, please login again', style: TextStyle(color: Colors.black)),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white60),
                child: const Text('ออกจากระบบ', style: TextStyle(color: Color.fromARGB(255, 255, 17, 0))),
                onPressed: () => UtilsApp.pushToLogin(context),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder<UserData?>(
      future: Api.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return expiredToken();
          } else {
            Size size = Size.fromHeight(MediaQuery.of(context).size.width > 720 ? 125 : 160);
            if (snapshot.data!.userLevel! == "4" || snapshot.data!.userLevel! == "3") {
              size = const Size.fromHeight(70);
            }
            if (!isFirst) {
              context.read<UsersBloc>().add(
                    SetUser(
                      snapshot.data!.displayName!,
                      snapshot.data!.userPic ?? "/img/default-pic.png",
                      snapshot.data!.userLevel!,
                      snapshot.data!.userId!,
                    ),
                  );
              Api.getDevice().then((value) {
                if (context.mounted) {
                  context.read<DevicesBloc>().add(GetAllDevices(value));
                  if (snapshot.data!.userLevel! == "4" || snapshot.data!.userLevel! == "3") {
                    context.read<DevicesBloc>().add(SetHospitalData(snapshot.data!.ward!.hosId!, snapshot.data!.wardId!));
                  }
                }
              }).catchError((error) {
                if (kDebugMode) print(error.toString());
                if (context.mounted) UtilsApp.pushToLogin(context);
              });
              Api.getNotification().then((value) {
                if (context.mounted) context.read<NotificationsBloc>().add(GetAllNotifications(value));
              }).catchError((error) {
                if (kDebugMode) print(error.toString());
                if (context.mounted) UtilsApp.pushToLogin(context);
              });
              isFirst = true;
            }

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: size,
                child: CustomAppbar(
                  titleInfo: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [TitleName(), ManuBar()],
                      ),
                      const SizedBox(height: 8),
                      snapshot.data!.userLevel! == "4" || snapshot.data!.userLevel! == "3" ? const SizedBox(height: 0) : const FilterBox(),
                    ],
                  ),
                ),
              ),
              body: Container(decoration: ConstColor.bgColor, child: const MachineList()),
            );
          }
        } else {
          return Scaffold(
            body: Container(
              decoration: ConstColor.bgColor,
              child: const Center(child: CircularProgressIndicator(color: Colors.white70)),
            ),
          );
        }
      },
    );
  }
}
