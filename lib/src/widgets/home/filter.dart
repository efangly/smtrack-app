import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/widgets/home/dropdown.dart';

class FilterBox extends StatefulWidget {
  final bool isTablet;
  const FilterBox({super.key, required this.isTablet});

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(SetHospital());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state.error) return const Center(child: Text("ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้"));
        if (state.hospital.isEmpty) return const Center(child: TextInputStyle.loading);
        if (state.hospital.isNotEmpty) {
          return DropdownHospital(isTablet: widget.isTablet, hospital: state.hospital);
        } else {
          return const Center(child: Text("ไม่มีข้อมูลโรงพยาบาล"));
        }
      },
    );
  }
}
