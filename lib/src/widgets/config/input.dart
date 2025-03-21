import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_noti/src/bloc/device/devices_bloc.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/config/device_info.dart';
import 'package:temp_noti/src/widgets/config/hospital_info.dart';
import 'package:temp_noti/src/widgets/config/manual_input.dart';
import 'package:temp_noti/src/widgets/config/ssid_input.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class InputConfig extends StatefulWidget {
  const InputConfig({super.key});

  @override
  State<InputConfig> createState() => _InputConfigState();
}

class _InputConfigState extends State<InputConfig> {
  String mode = "0";
  String? host;
  String? ward;
  bool isManual = false;
  bool isSubmit = false;
  final formKey = GlobalKey<FormState>();
  final devSerialController = TextEditingController();
  final deviceNameController = TextEditingController();
  final devicePositionController = TextEditingController();
  final deviceLocationController = TextEditingController();
  final ssidController = TextEditingController();
  final wifipasswordController = TextEditingController();
  final ipController = TextEditingController();
  final subnetController = TextEditingController();
  final gatewayController = TextEditingController();
  final dnsController = TextEditingController();
  Future<void> warning(String title, String data) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.white70)),
          content: Text(data, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 0, 77, 192),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white60),
              child: const Text('OK', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void setHospital(String hosId, String wardId) {
    setState(() {
      host = hosId;
      ward = wardId;
    });
  }

  @override
  void dispose() {
    super.dispose();
    devSerialController.dispose();
    deviceNameController.dispose();
    devicePositionController.dispose();
    deviceLocationController.dispose();
    ssidController.dispose();
    wifipasswordController.dispose();
    ipController.dispose();
    subnetController.dispose();
    gatewayController.dispose();
    dnsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 700 ? true : false;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: isTablet ? 600 : 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Device Info",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          isSubmit = true;
                          if (devSerialController.text.isEmpty) {
                            warning("Warning", "Please scan serial number first!!");
                            isSubmit = false;
                            return;
                          }
                          if (ssidController.text.isEmpty || wifipasswordController.text.isEmpty) {
                            warning("Warning", "Please fill in the wifi information!!");
                            isSubmit = false;
                            return;
                          }
                          if (isManual) {
                            if (ipController.text.isEmpty ||
                                subnetController.text.isEmpty ||
                                gatewayController.text.isEmpty ||
                                dnsController.text.isEmpty) {
                              warning("Warning", "Please fill in the network information!!");
                              isSubmit = false;
                              return;
                            }
                          }
                          Configs configs = Configs(
                            hosId: host,
                            wardId: ward,
                            deviceName: deviceNameController.text.isEmpty ? null : deviceNameController.text,
                            devicePosition: devicePositionController.text.isEmpty ? null : devicePositionController.text,
                            deviceLocation: deviceLocationController.text.isEmpty ? null : deviceLocationController.text,
                            config: NetworkConfig(
                              ssid: ssidController.text,
                              wifiPassword: wifipasswordController.text,
                              mode: mode,
                              ip: isManual ? ipController.text : null,
                              subnet: isManual ? subnetController.text : null,
                              gateway: isManual ? gatewayController.text : null,
                              dns: isManual ? dnsController.text : null,
                            ),
                          );
                          try {
                            bool result = await Api.updateDevice(devSerialController.text, configs);
                            if (result) {
                              await warning("Successful", "Device configuration saved!!");
                              List<DeviceList> device = await Api.getDevice();
                              setState(() {
                                isSubmit = false;
                                context.read<DevicesBloc>().add(GetAllDevices(device));
                                devSerialController.clear();
                                deviceNameController.clear();
                                devicePositionController.clear();
                                deviceLocationController.clear();
                                ssidController.clear();
                                wifipasswordController.clear();
                                ipController.clear();
                                subnetController.clear();
                                gatewayController.clear();
                                dnsController.clear();
                                Navigator.of(context).pop();
                              });
                            } else {
                              await warning("Warning", "Failed to save device configuration!!");
                            }
                          } on Exception catch (error) {
                            isSubmit = false;
                            if (kDebugMode) print(error.toString());
                            if (context.mounted) UtilsApp.pushToLogin(context);
                          }
                        },
                        icon: Icon(Icons.save, color: Colors.white70, size: isTablet ? 35 : 25),
                        label: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isTablet ? 22 : 18,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12, thickness: 1, height: 10),
                  TextField(
                    readOnly: true,
                    controller: devSerialController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Serial Number',
                      helperText: 'Tap QR icon for serial number',
                      labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                      helperStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70),
                      contentPadding: const EdgeInsets.only(left: 8, top: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          var res = await Navigator.pushNamed(context, custom_route.Route.barcode);
                          if (res == null) return;
                          try {
                            DeviceId? device = await Api.getDeviceById(res.toString());
                            if (device != null) {
                              devSerialController.text = device.devSerial ?? "";
                            } else {
                              devSerialController.text = "";
                              warning("Warning", "Device not found!!");
                            }
                          } catch (error) {
                            if (kDebugMode) print(error.toString());
                            if (context.mounted) UtilsApp.pushToLogin(context);
                          }
                        },
                        icon: Icon(Icons.qr_code_2, color: Colors.white70, size: isTablet ? 45 : 35),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  HospitalInfo(setHospital: setHospital),
                  DeviceInfo(
                    deviceName: deviceNameController,
                    devicePosition: devicePositionController,
                    deviceLocation: deviceLocationController,
                  ),
                  const SizedBox(height: 15),
                  Text("Network Info", style: TextStyle(color: Colors.white70, fontSize: isTablet ? 24 : 20, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.white12, thickness: 1, height: 10),
                  InputWifiInfo(ssid: ssidController, wifipassword: wifipasswordController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: RadioListTile<String>(
                          selected: true,
                          title: const Text('Auto', style: TextStyle(color: Colors.white70)),
                          fillColor: WidgetStateProperty.all(Colors.white60),
                          value: "0",
                          groupValue: mode,
                          onChanged: (value) {
                            setState(() {
                              mode = value ?? "0";
                              isManual = false;
                              ipController.clear();
                              subnetController.clear();
                              gatewayController.clear();
                              dnsController.clear();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: RadioListTile<String>(
                          title: const Text('Manual', style: TextStyle(color: Colors.white70)),
                          fillColor: WidgetStateProperty.all(Colors.white60),
                          value: "1",
                          groupValue: mode,
                          onChanged: (value) {
                            setState(() {
                              mode = value ?? "1";
                              isManual = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  ManualNework(
                    ipController: ipController,
                    subnetController: subnetController,
                    gatewayController: gatewayController,
                    dnsController: dnsController,
                    isEnable: isManual,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
