part of 'devices_bloc.dart';

class DevicesState extends Equatable {
  final List<DeviceInfo> devices;
  final List<DeviceLegacyList> legacyDevice;
  final DeviceId? device;
  final bool isError;
  const DevicesState({
    this.devices = const [],
    this.legacyDevice = const [],
    this.device,
    this.isError = false,
  });

  DevicesState copyWith({
    List<DeviceInfo>? devices,
    List<DeviceLegacyList>? legacyDevice,
    DeviceId? device,
    bool? isError,
  }) {
    return DevicesState(
      devices: devices ?? this.devices,
      legacyDevice: legacyDevice ?? this.legacyDevice,
      device: device ?? this.device,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [devices, legacyDevice, device ?? DeviceId(), isError];
}
