import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:temp_noti/src/constants/mqtt_config.dart';
import 'package:temp_noti/src/models/temp.dart';
import 'package:uuid/uuid.dart';

class TempInfo extends StatefulWidget {
  const TempInfo({super.key, required this.devSerial});
  final String? devSerial;

  @override
  State<TempInfo> createState() => _TempInfoState();
}

class _TempInfoState extends State<TempInfo> {
  late MqttServerClient client;
  double temp = 0.0;
  double humi = 0.0;
  String mqttId = 'client-${const Uuid().v4()}';
  @override
  void initState() {
    super.initState();
    initMqtt();
    if (kDebugMode) {
      print(mqttId);
    }
  }

  @override
  void dispose() {
    publish("off");
    disconnectMQTT();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('อุณหภูมิ : $temp', style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 20),
        Text('ความชื้น : $humi', style: const TextStyle(fontSize: 40)),
      ],
    );
  }

  void initMqtt() async {
    client = MqttServerClient(MqttConf.MQTT_SERVER, mqttId)
      ..autoReconnect = true
      ..keepAlivePeriod = 60
      ..port = MqttConf.MQTT_PORT
      ..onConnected = onConnected
      ..onDisconnected = onDisConnected
      ..secure = true;
    await connectMqtt();
  }

  Future<void> connectMqtt() async {
    try {
      await client.connect(MqttConf.MQTT_USERNAME, MqttConf.MQTT_PASSWORD);
      client.subscribe("${widget.devSerial}/temp/real", MqttQos.atMostOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        Temp tempInfo = Temp.fromJson(json.decode(pt));
        if (kDebugMode) {
          print('Received message: topic is ${c[0].topic}, payload is $pt');
        }
        setState(() {
          temp = tempInfo.temp ?? 0.0;
          humi = tempInfo.humi ?? 0.0;
        });
      });
    } on NoConnectionException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      client.disconnect();
    } on SocketException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      client.disconnect();
    }
  }

  void disconnectMQTT() {
    try {
      client.disconnect();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void onConnected() {
    if (kDebugMode) {
      print('MQTT Connected');
      print(widget.devSerial);
    }
    publish("on");
  }

  void onDisConnected() {
    if (kDebugMode) {
      print('MQTT Disconnected');
    }
  }

  String getDevice(String device) {
    String product = device.substring(0, 3) == "iTS" ? 'items' : 'etemp';
    String version = device.substring(3, 5).toLowerCase();
    return "$product/$version";
  }

  void publish(String message) {
    try {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(
        '${widget.devSerial}/temp',
        MqttQos.atLeastOnce,
        builder.payload!,
      );
      client.publishMessage(
        'siamatic/${getDevice(widget.devSerial!)}/${widget.devSerial}/temp',
        MqttQos.atLeastOnce,
        builder.payload!,
      );
      builder.clear();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}
