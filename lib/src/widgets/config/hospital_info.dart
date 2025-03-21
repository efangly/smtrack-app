import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';

class HospitalInfo extends StatefulWidget {
  final void Function(String hosId, String wardId) setHospital;
  const HospitalInfo({super.key, required this.setHospital});

  @override
  State<HospitalInfo> createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  List<Ward> wards = [];
  String? hos;

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    Future<List<HospitalData>> getHospital() async {
      try {
        List<HospitalData> hospital = await Api.getHospital();
        if (wards.isEmpty) wards = hospital.first.ward!;
        return hospital;
      } catch (error) {
        if (kDebugMode) print(error.toString());
        if (context.mounted) UtilsApp.pushToLogin(context);
        return [];
      }
    }

    return FutureBuilder(
        future: getHospital(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          if (snap.data!.isEmpty) return const Center(child: CircularProgressIndicator());
          List<HospitalData> hospital = snap.data ?? [];
          return Column(
            children: [
              DropdownMenu<String>(
                initialSelection: hospital.first.hosId!,
                menuHeight: MediaQuery.of(context).size.height * 0.5,
                label: const Text('Hospital'),
                onSelected: (val) {
                  wards = hospital.firstWhere((e) => e.hosId == val).ward!;
                  hos = val;
                  widget.setHospital(val!, wards.first.wardId!);
                  setState(() {});
                },
                inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                textStyle: const TextStyle(fontSize: 14),
                width: isTablet ? 540 : 390,
                leadingIcon: const Icon(Icons.local_hospital, color: Colors.white70, size: 35),
                trailingIcon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white70, size: 30),
                dropdownMenuEntries: hospital.map<DropdownMenuEntry<String>>((HospitalData value) {
                  return DropdownMenuEntry<String>(
                    value: value.hosId!,
                    label: value.hosName!,
                    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              DropdownMenu<String>(
                initialSelection: wards.first.wardId!,
                menuHeight: MediaQuery.of(context).size.height * 0.5,
                label: const Text('Ward'),
                onSelected: (val) => widget.setHospital(hos ?? hospital.first.hosId!, val!),
                inputDecorationTheme: TextInputStyle.inputDecorationStyle,
                menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                textStyle: const TextStyle(fontSize: 14),
                width: isTablet ? 540 : 390,
                leadingIcon: const Icon(Icons.location_city, color: Colors.white70, size: 35),
                trailingIcon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white70, size: 30),
                dropdownMenuEntries: wards.map<DropdownMenuEntry<String>>((Ward value) {
                  return DropdownMenuEntry<String>(
                    value: value.wardId!,
                    label: value.wardName!,
                    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],
          );
        });
  }
}
