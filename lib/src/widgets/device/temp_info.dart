import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_noti/src/services/mqtt.dart';

class TempInfo extends StatefulWidget {
  final String devSerial;
  final String probe;
  const TempInfo({super.key, required this.devSerial, required this.probe});

  @override
  State<TempInfo> createState() => _TempInfoState();
}

class _TempInfoState extends State<TempInfo> {
  final client = MqttService();
  double temp = 0.0;
  double humi = 0.0;
  @override
  void initState() {
    super.initState();
    client.connect().then((value) {
      if (value) {
        client.subscribe("${widget.devSerial}/temp/real");
        client.publish("${widget.devSerial}/temp", "on");
        client.publish("siamatic/${client.getDevice(widget.devSerial)}/${widget.devSerial}/temp", "on");
        client.publish("siamatic/${client.getDevice(widget.devSerial)}/${widget.devSerial}/${widget.probe}/temp", "on");
      }
    });
    client.messageStream.listen((event) {
      if (kDebugMode) print(event['temp']);
      if (kDebugMode) print(event['humi']);
      setState(() {
        temp = event['temp'] ?? 0.0;
        humi = event['humi'] ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    client.publish('${widget.devSerial}/temp', "off");
    client.publish('siamatic/${client.getDevice(widget.devSerial)}/${widget.devSerial}/temp', "off");
    client.publish("siamatic/${client.getDevice(widget.devSerial)}/${widget.devSerial}/${widget.probe}/temp", "off");
    client.unsubscribe("${widget.devSerial}/temp/real");
    client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FaIcon(FontAwesomeIcons.temperatureLow, size: 50),
              Text('${temp.toStringAsFixed(2)}°C', style: const TextStyle(fontSize: 40)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.water_drop_outlined, size: 55),
              Text('${humi.toStringAsFixed(2)} %', style: const TextStyle(fontSize: 40)),
            ],
          ),
        ],
      ),
    );
  }
}
