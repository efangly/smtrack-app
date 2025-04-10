import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/configs/url.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/models/users.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/home/filter.dart';
import 'package:temp_noti/src/widgets/home/machine_legacy.dart';
import 'package:temp_noti/src/widgets/home/menu.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/home/machine_list.dart';
import 'package:temp_noti/src/widgets/home/title.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/utils/preference.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Api();
    final configStorage = ConfigStorage();
    bool isFirst = false;
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    context.read<DevicesBloc>().add(ClearDevices());
    return FutureBuilder<UserData?>(
      future: api.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              decoration: ConstColor.bgColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("เกิดข้อผิดพลาดในการเชื่อมต่อ", style: TextStyle(color: Colors.white70, fontSize: 20)),
                    const SizedBox(height: 10),
                    const Text("กรุณาล๊อคอินใหม่อีกครั้ง", style: TextStyle(color: Colors.white70, fontSize: 18)),
                    const SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.white60),
                      child: const Text('ตกลง', style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        configStorage.clearTokens();
                        context.read<UsersBloc>().add(RemoveUser());
                        context.read<DevicesBloc>().add(ClearDevices());
                        Navigator.pushNamedAndRemoveUntil(context, custom_route.Route.login, (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          Size size = Size.fromHeight(MediaQuery.of(context).size.width > 720 ? 125 : 160);
          if (snapshot.data!.role! == "USER" || snapshot.data!.role! == "LEGACY_USER" || snapshot.data!.role! == "GUEST") {
            size = const Size.fromHeight(70);
          }
          if (!isFirst) {
            context.read<UsersBloc>().add(
                  SetUser(
                    snapshot.data!.display!,
                    snapshot.data!.pic ?? URL.DEFAULT_PIC,
                    snapshot.data!.role!,
                    snapshot.data!.id!,
                    snapshot.data!.username!,
                  ),
                );
            if (snapshot.data!.role! == "USER" || snapshot.data!.role! == "GUEST") {
              context.read<DevicesBloc>().add(GetDevices(snapshot.data!.wardId!));
              context.read<DevicesBloc>().add(
                    SetHospitalData(
                      snapshot.data!.ward!.hosId!,
                      snapshot.data!.wardId!,
                      snapshot.data!.ward!.type!,
                    ),
                  );
            }
            if (snapshot.data!.role! == "LEGACY_USER") {
              context.read<DevicesBloc>().add(GetLegacyDevices(snapshot.data!.wardId!));
              context.read<DevicesBloc>().add(
                    SetHospitalData(
                      snapshot.data!.ward!.hosId!,
                      snapshot.data!.wardId!,
                      snapshot.data!.ward!.type!,
                    ),
                  );
            }
            isFirst = true;
          }

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: size,
              child: CustomAppbar(
                titleInfo: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [TitleName(isTablet: isTablet), MenuList(isTablet: isTablet)],
                    ),
                    const SizedBox(height: 8),
                    snapshot.data!.role! == "USER" || snapshot.data!.role! == "LEGACY_USER" || snapshot.data!.role! == "GUEST"
                        ? const SizedBox(height: 0)
                        : const FilterBox(),
                  ],
                ),
              ),
            ),
            body: BlocBuilder<DevicesBloc, DevicesState>(
              builder: (context, state) {
                return Container(
                  decoration: ConstColor.bgColor,
                  child: state.wardType == ""
                      ? snapshot.data!.ward!.type == "LEGACY"
                          ? const MachineLegacy()
                          : const MachineList()
                      : state.wardType == "LEGACY"
                          ? const MachineLegacy()
                          : const MachineList(),
                );
              },
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              decoration: ConstColor.bgColor,
              child: const Center(child: TextInputStyle.loading),
            ),
          );
        }
      },
    );
  }
}
