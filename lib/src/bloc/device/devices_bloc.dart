import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temp_noti/src/models/models.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(const DevicesState()) {
    on<GetAllDevices>((event, emit) async {
      emit(state.copyWith(devices: event.devices));
    });

    on<SetHospitalData>((event, emit) {
      emit(state.copyWith(hospitalId: event.hospitalId, wardId: event.wardId));
    });

    on<SetWardData>((event, emit) {
      emit(state.copyWith(wards: event.wards));
    });

    on<ClearDevices>((event, emit) {
      emit(state.copyWith(devices: [], wards: [], wardId: "", hospitalId: ""));
    });

    on<DeviceError>((event, emit) {
      emit(state.copyWith(isError: event.error));
    });
  }
}
