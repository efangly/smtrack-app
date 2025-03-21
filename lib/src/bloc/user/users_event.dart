part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class SetUser extends UsersEvent {
  final String displayName;
  final String userPic;
  final String role;
  final String userId;

  const SetUser(this.displayName, this.userPic, this.role, this.userId);
}

class RemoveUser extends UsersEvent {}
