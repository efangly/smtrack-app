import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/models/models.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    List<Ward> wards = [];
    context.read<UsersBloc>().add(LoadHospital());
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state.error) {
          context.read<UsersBloc>().add(const SetError(false));
          return const Center(child: Text("ไม่สามารถโหลดข้อมูลโรงพยาบาล"));
        }
        if (state.hospital.isNotEmpty) {
          if (wards.isEmpty) {
            wards = state.hospital.first.ward!;
            Ward? ward = wards.firstWhere((u) => u.id == wards.first.id!);
            context.read<UsersBloc>().add(SetHospitalData(state.hospital.first.id!, state.hospital.first.ward!.first.id!, ward.type!));
            context.read<DevicesBloc>().add(GetDevices(state.hospital.first.ward!.first.id!));
          }
          List<Widget> dropdown = [
            DropdownMenu<String>(
              width: 350,
              menuHeight: MediaQuery.of(context).size.height * 0.5,
              initialSelection: state.hospital.first.id!,
              label: const Text('โรงพยาบาล', style: TextStyle(fontSize: 18)),
              menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onSelected: (val) {
                final wardVal = state.hospital.firstWhere((e) => e.id == val).ward!.first.id!;
                final wardValType = state.hospital.firstWhere((e) => e.id == val).ward!.first.type!;
                context.read<UsersBloc>().add(SetHospitalData(val!, wardVal, wardValType));
                if (wardValType == "NEW") {
                  context.read<DevicesBloc>().add(GetDevices(wardVal));
                } else {
                  context.read<DevicesBloc>().add(GetLegacyDevices(wardVal));
                }
                wards = state.hospital.firstWhere((e) => e.id == val).ward!;
              },
              dropdownMenuEntries: state.hospital.map<DropdownMenuEntry<String>>((HospitalData value) {
                return DropdownMenuEntry<String>(
                  value: value.id!,
                  label: value.hosName!,
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                );
              }).toList(),
              inputDecorationTheme: TextInputStyle.inputDecorationStyle,
              trailingIcon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white70, size: 30.0),
              textStyle: TextStyle(fontSize: isTablet ? 16 : 14),
            ),
            const SizedBox(height: 13),
            DropdownMenu<String>(
              width: 350,
              menuHeight: MediaQuery.of(context).size.height * 0.5,
              initialSelection: state.wardId,
              label: const Text('วอร์ด', style: TextStyle(fontSize: 18)),
              menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onSelected: (val) {
                Ward? ward = wards.firstWhere((u) => u.id == val!);
                context.read<UsersBloc>().add(SetHospitalData(state.hospitalId, val!, ward.type!));
                if (ward.type == "NEW") {
                  context.read<DevicesBloc>().add(GetDevices(val));
                } else {
                  context.read<DevicesBloc>().add(GetLegacyDevices(val));
                }
              },
              dropdownMenuEntries: wards.map<DropdownMenuEntry<String>>((Ward value) {
                return DropdownMenuEntry<String>(
                  value: value.id!,
                  label: value.wardName!,
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                );
              }).toList(),
              inputDecorationTheme: TextInputStyle.inputDecorationStyle,
              trailingIcon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white70, size: 30.0),
              textStyle: TextStyle(fontSize: isTablet ? 16 : 14),
            ),
          ];
          return MediaQuery.of(context).size.width > 720
              ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: dropdown)
              : Column(crossAxisAlignment: CrossAxisAlignment.center, children: dropdown);
        } else {
          return const Center(child: Text("ไม่มีข้อมูลโรงพยาบาล"));
        }
      },
    );
  }
}
