import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<SetUser>((event, emit) {
      emit(state.copyWith(displayName: event.displayName, userPic: event.userPic, role: event.role, userId: event.userId));
    });
    on<RemoveUser>((event, emit) {
      emit(state.copyWith(displayName: '', userPic: '/img/default-pic.png', role: '4'));
    });
  }
}
