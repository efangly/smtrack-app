import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    List<Ward> wards = [];
    return FutureBuilder<List<HospitalData>>(
      future: Api.getHospital(),
      builder: (context, snap) {
        return BlocBuilder<DevicesBloc, DevicesState>(
          builder: (context, state) {
            if (snap.hasData) {
              if (wards.isEmpty) {
                wards = snap.data!.first.ward!;
                context.read<DevicesBloc>().add(SetHospitalData(snap.data!.first.hosId!, snap.data!.first.ward!.first.wardId!));
              }
              List<Widget> dropdown = [
                DropdownMenu<String>(
                  width: 350,
                  menuHeight: MediaQuery.of(context).size.height * 0.5,
                  initialSelection: snap.data!.first.hosId!,
                  label: const Text('Hospital', style: TextStyle(fontSize: 18)),
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (val) {
                    context
                        .read<DevicesBloc>()
                        .add(SetHospitalData(val!, snap.data!.firstWhere((e) => e.hosId == val).ward!.first.wardId!));
                    wards = snap.data!.firstWhere((e) => e.hosId == val).ward!;
                  },
                  dropdownMenuEntries: snap.data!.map<DropdownMenuEntry<String>>((HospitalData value) {
                    return DropdownMenuEntry<String>(
                      value: value.hosId!,
                      label: value.hosName!,
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                    );
                  }).toList(),
                  inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                  trailingIcon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white70, size: 30.0),
                  textStyle: TextStyle(fontSize: isTablet ? 16 : 14),
                ),
                const SizedBox(height: 8),
                DropdownMenu<String>(
                  width: 350,
                  menuHeight: MediaQuery.of(context).size.height * 0.5,
                  initialSelection: state.wardId,
                  label: const Text('Ward', style: TextStyle(fontSize: 18)),
                  menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onSelected: (val) {
                    context.read<DevicesBloc>().add(SetHospitalData(state.hospitalId, val!));
                  },
                  dropdownMenuEntries: wards.map<DropdownMenuEntry<String>>((Ward value) {
                    return DropdownMenuEntry<String>(
                      value: value.wardId!,
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
              return const Center(child: CircularProgressIndicator(color: Colors.white70));
            }
          },
        );
      },
    );
  }
}
