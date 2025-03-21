part of 'devices_bloc.dart';

class DevicesState extends Equatable {
  final List<DeviceList> devices;
  final List<Ward> wards;
  final String hospitalId;
  final String wardId;
  final bool isError;
  const DevicesState({
    this.devices = const [],
    this.wards = const [],
    this.hospitalId = '',
    this.wardId = '',
    this.isError = false,
  });

  DevicesState copyWith({
    List<DeviceList>? devices,
    List<Ward>? wards,
    String? hospitalId,
    String? wardId,
    bool? isError,
  }) {
    return DevicesState(
      devices: devices ?? this.devices,
      wards: wards ?? this.wards,
      hospitalId: hospitalId ?? this.hospitalId,
      wardId: wardId ?? this.wardId,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [devices, hospitalId, wards, wardId, isError];
}
