import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/models/models.dart';

class DropdownHospital extends StatefulWidget {
  final List<HospitalData> hospital;
  final bool isTablet;
  const DropdownHospital({super.key, required this.isTablet, required this.hospital});

  @override
  State<DropdownHospital> createState() => _DropdownHospitalState();
}

class _DropdownHospitalState extends State<DropdownHospital> {
  List<Ward> wards = [];

  @override
  Widget build(BuildContext context) {
    if (wards.isEmpty) {
      wards = widget.hospital.first.ward!;
      Ward? ward = wards.firstWhere((u) => u.id == wards.first.id!);
      context.read<DevicesBloc>().add(SetHospitalData(widget.hospital.first.id!, widget.hospital.first.ward!.first.id!, ward.type!));
      context.read<DevicesBloc>().add(GetDevices(widget.hospital.first.ward!.first.id!));
    }
    List<Widget> dropdown = [
      DropdownMenu<String>(
        width: 350,
        menuHeight: MediaQuery.of(context).size.height * 0.5,
        initialSelection: widget.hospital.first.id!,
        label: const Text('โรงพยาบาล', style: TextStyle(fontSize: 18)),
        menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
        onSelected: (val) {
          final wardVal = widget.hospital.firstWhere((e) => e.id == val).ward!.first.id!;
          final wardValType = widget.hospital.firstWhere((e) => e.id == val).ward!.first.type!;
          context.read<DevicesBloc>().add(SetHospitalData(val!, wardVal, wardValType));
          if (wardValType == "NEW") {
            context.read<DevicesBloc>().add(GetDevices(wardVal));
          } else {
            context.read<DevicesBloc>().add(GetLegacyDevices(wardVal));
          }
          setState(() => wards = widget.hospital.firstWhere((e) => e.id == val).ward!);
        },
        dropdownMenuEntries: widget.hospital.map<DropdownMenuEntry<String>>((HospitalData value) {
          return DropdownMenuEntry<String>(
            value: value.id!,
            label: value.hosName!,
            style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
          );
        }).toList(),
        inputDecorationTheme: TextInputStyle.inputDecorationStyle,
        trailingIcon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white70, size: 30.0),
        textStyle: TextStyle(fontSize: widget.isTablet ? 16 : 14),
      ),
      const SizedBox(height: 13),
      DropdownMenu<String>(
        width: 350,
        menuHeight: MediaQuery.of(context).size.height * 0.5,
        initialSelection: wards.first.id!,
        label: const Text('วอร์ด', style: TextStyle(fontSize: 18)),
        menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
        onSelected: (val) {
          Ward? ward = wards.firstWhere((u) => u.id == val!);
          context.read<DevicesBloc>().add(SetHospitalData(widget.hospital.first.id!, val!, ward.type!));
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
        textStyle: TextStyle(fontSize: widget.isTablet ? 16 : 14),
      ),
    ];
    return widget.isTablet
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: dropdown)
        : Column(crossAxisAlignment: CrossAxisAlignment.center, children: dropdown);
  }
}
