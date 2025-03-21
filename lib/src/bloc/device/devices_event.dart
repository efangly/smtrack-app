part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object> get props => [];
}

class GetAllDevices extends DevicesEvent {
  final List<DeviceList> devices;
  const GetAllDevices(this.devices);
}

class SetHospitalData extends DevicesEvent {
  final String hospitalId;
  final String wardId;
  const SetHospitalData(this.hospitalId, this.wardId);

  @override
  List<Object> get props => [hospitalId, wardId];
}

class SetWardData extends DevicesEvent {
  final List<Ward> wards;
  const SetWardData(this.wards);

  @override
  List<Object> get props => [wards];
}

class ClearDevices extends DevicesEvent {}

class DeviceError extends DevicesEvent {
  final bool error;
  const DeviceError(this.error);

  @override
  List<Object> get props => [error];
}
