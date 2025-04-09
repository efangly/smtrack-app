part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class SetUser extends UsersEvent {
  final String display;
  final String pic;
  final String role;
  final String id;
  final String username;

  const SetUser(this.display, this.pic, this.role, this.id, this.username);

  @override
  List<Object> get props => [display, pic, role, id];
}

class SetHospitalData extends UsersEvent {
  final String hospitalId;
  final String wardId;
  final String wardType;
  const SetHospitalData(this.hospitalId, this.wardId, this.wardType);

  @override
  List<Object> get props => [hospitalId, wardId, wardType];
}

class SetWardData extends UsersEvent {
  final List<Ward> wards;
  const SetWardData(this.wards);

  @override
  List<Object> get props => [wards];
}

class SetError extends UsersEvent {
  final bool error;
  const SetError(this.error);

  @override
  List<Object> get props => [error];
}

class RemoveUser extends UsersEvent {}

class LoadHospital extends UsersEvent {}
