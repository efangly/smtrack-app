import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temp_noti/src/configs/url.dart';
import 'package:temp_noti/src/models/hospitals.dart';
import 'package:temp_noti/src/services/services.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final api = Api();
  UsersBloc() : super(const UsersState()) {
    on<SetUser>(_onSetUser);
    on<RemoveUser>(_onRemoveUser);
    on<SetHospitalData>(_onSetHospitalData);
    on<SetWardData>(_onSetWardData);
    on<SetError>(_onSetError);
    on<LoadHospital>(_onLoadHospital);
  }

  void _onSetUser(SetUser event, Emitter<UsersState> emit) {
    emit(state.copyWith(display: event.display, pic: event.pic, role: event.role, id: event.id));
  }

  void _onRemoveUser(RemoveUser event, Emitter<UsersState> emit) {
    emit(state.copyWith(display: '-', pic: URL.DEFAULT_PIC, role: 'GUEST', id: ''));
  }

  void _onSetHospitalData(SetHospitalData event, Emitter<UsersState> emit) {
    emit(state.copyWith(hospitalId: event.hospitalId, wardId: event.wardId, wardType: event.wardType));
  }

  void _onSetWardData(SetWardData event, Emitter<UsersState> emit) {
    emit(state.copyWith(wards: event.wards));
  }

  void _onSetError(SetError event, Emitter<UsersState> emit) {
    emit(state.copyWith(error: event.error));
  }

  void _onLoadHospital(LoadHospital event, Emitter<UsersState> emit) async {
    try {
      List<HospitalData> hospital = await api.getHospital();
      emit(state.copyWith(hospital: hospital));
    } on Exception catch (e) {
      emit(state.copyWith(error: true));
      if (kDebugMode) print(e);
    }
  }
}
