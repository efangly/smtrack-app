import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/widgets/home/filter.dart';
import 'package:temp_noti/src/widgets/home/machine_legacy.dart';
import 'package:temp_noti/src/widgets/home/menu.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/home/machine_list.dart';
import 'package:temp_noti/src/widgets/home/title.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;
import 'package:temp_noti/src/widgets/utils/preference.dart';
import 'package:temp_noti/src/widgets/utils/responsive.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final configStorage = ConfigStorage();

  @override
  void initState() {
    super.initState();
    context.read<DevicesBloc>().add(ClearDevices());
    context.read<UsersBloc>().add(SetUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, snapshot) {
        if (snapshot.error) {
          ShowSnackbar.snackbar(ContentType.success, "เกิดข้อผิดพลาดในการเชื่อมต่อ", "กรุณาล๊อคอินใหม่อีกครั้ง");
          configStorage.clearTokens();
          custom_route.Route.navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
        }
        if (snapshot.username != "") {
          Size size = Size.fromHeight(Responsive.isTablet ? 125 : 160);
          if (snapshot.role == "USER" || snapshot.role == "GUEST") {
            size = const Size.fromHeight(70);
            context.read<DevicesBloc>().add(GetDevices(snapshot.ward));
            context.read<DevicesBloc>().add(SetHospitalData(snapshot.hospitalId, snapshot.ward, snapshot.type));
          }
          if (snapshot.role == "LEGACY_USER") {
            size = const Size.fromHeight(70);
            context.read<DevicesBloc>().add(GetLegacyDevices(snapshot.ward));
            context.read<DevicesBloc>().add(SetHospitalData(snapshot.hospitalId, snapshot.ward, snapshot.type));
          }

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: size,
              child: CustomAppbar(
                titleInfo: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [TitleName(isTablet: Responsive.isTablet), MenuList(isTablet: Responsive.isTablet)],
                    ),
                    const SizedBox(height: 8),
                    snapshot.role == "USER" || snapshot.role == "LEGACY_USER" || snapshot.role == "GUEST"
                        ? const SizedBox(height: 0)
                        : FilterBox(isTablet: Responsive.isTablet),
                  ],
                ),
              ),
            ),
            body: BlocBuilder<DevicesBloc, DevicesState>(
              builder: (context, state) {
                return Container(
                  decoration: ConstColor.bgColor,
                  child: state.wardType == ""
                      ? snapshot.type == "LEGACY"
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
