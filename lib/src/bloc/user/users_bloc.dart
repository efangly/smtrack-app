import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:temp_noti/src/configs/url.dart';
import 'package:temp_noti/src/models/hospitals.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<SetUser>(_onSetUser);
    on<RemoveUser>(_onRemoveUser);
    on<SetWardData>(_onSetWardData);
    on<SetError>(_onSetError);
    on<SetHospital>(_onSetHospital);
  }

  void _onSetUser(SetUser event, Emitter<UsersState> emit) {
    emit(state.copyWith(display: event.display, pic: event.pic, role: event.role, id: event.id));
  }

  void _onRemoveUser(RemoveUser event, Emitter<UsersState> emit) {
    emit(state.copyWith(display: '-', pic: URL.DEFAULT_PIC, role: 'GUEST', id: ''));
  }

  void _onSetWardData(SetWardData event, Emitter<UsersState> emit) {
    emit(state.copyWith(wards: event.wards));
  }

  void _onSetError(SetError event, Emitter<UsersState> emit) {
    emit(state.copyWith(error: event.error));
  }

  void _onSetHospital(SetHospital event, Emitter<UsersState> emit) async {
    emit(state.copyWith(hospital: event.hospital));
  }
}
