import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/user/users_bloc.dart';
import 'package:temp_noti/src/constants/style.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/home/dropdown.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Api();
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    return FutureBuilder<List<HospitalData>>(
      future: api.getHospital(),
      builder: (context, state) {
        if (state.hasError) return const Center(child: Text("ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้"));
        if (state.connectionState == ConnectionState.waiting) return const Center(child: TextInputStyle.loading);
        if (state.hasData && state.data!.isNotEmpty) {
          context.read<UsersBloc>().add(SetHospital(state.data!));
          return DropdownHospital(isTablet: isTablet, hospital: state.data!);
        } else {
          return const Center(child: Text("ไม่มีข้อมูลโรงพยาบาล"));
        }
      },
    );
  }
}
