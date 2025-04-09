import 'package:flutter/material.dart';
import 'package:temp_noti/src/models/models.dart';

class ConfigInfo extends StatelessWidget {
  final bool isTablet;
  final Probe probe;
  const ConfigInfo({super.key, required this.isTablet, required this.probe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ชื่อ : ${probe.name ?? "-"}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text('อุณหภูมิต่ำสุด : ${probe.tempMin ?? "-"}', style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('อุณหภูมิสูงสุด : ${probe.tempMax ?? "-"}', style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ตำแหน่ง : ${probe.position ?? "-"}',
              style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text('ความชื้นต่ำสุด : ${probe.humiMin ?? "-"}', style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('ความชื้นสูงสุด : ${probe.humiMax ?? "-"}', style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
          ],
        ),
      ],
    );
  }
}
