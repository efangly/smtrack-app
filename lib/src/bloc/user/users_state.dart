part of 'users_bloc.dart';

class UsersState extends Equatable {
  final String displayName;
  final String userPic;
  final String role;
  final String userId;
  const UsersState({this.displayName = "", this.userPic = "/img/default-pic.png", this.role = "4", this.userId = ""});

  UsersState copyWith({String? displayName, String? userPic, String? role, String? userId}) {
    return UsersState(
        displayName: displayName ?? this.displayName,
        userPic: userPic ?? this.userPic,
        role: role ?? this.role,
        userId: userId ?? this.userId);
  }

  @override
  List<Object> get props => [displayName, userPic, role, userId];
}
