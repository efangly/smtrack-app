part of 'users_bloc.dart';

class UsersState extends Equatable {
  final String display;
  final String pic;
  final String role;
  final String id;
  final String username;
  final bool error;
  final List<HospitalData> hospital;
  final List<Ward> wards;
  final String hospitalId;
  final String wardId;
  final String wardType;

  const UsersState({
    this.display = "",
    this.pic = URL.DEFAULT_PIC,
    this.role = "GUEST",
    this.id = "",
    this.username = "",
    this.error = false,
    this.hospital = const [],
    this.wards = const [],
    this.hospitalId = "",
    this.wardId = "",
    this.wardType = "",
  });

  UsersState copyWith({
    String? display,
    String? pic,
    String? role,
    String? id,
    String? username,
    bool? error,
    List<HospitalData>? hospital,
    List<Ward>? wards,
    String? hospitalId,
    String? wardId,
    String? wardType,
  }) {
    return UsersState(
      display: display ?? this.display,
      pic: pic ?? this.pic,
      role: role ?? this.role,
      id: id ?? this.id,
      username: username ?? this.username,
      error: error ?? this.error,
      hospital: hospital ?? this.hospital,
      wards: wards ?? this.wards,
      hospitalId: hospitalId ?? this.hospitalId,
      wardId: wardId ?? this.wardId,
      wardType: wardType ?? this.wardType,
    );
  }

  @override
  List<Object> get props => [display, pic, role, id, username, error, hospital, wards, hospitalId, wardId, wardType];
}
