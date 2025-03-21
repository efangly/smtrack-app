import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/widgets/detail/detail_info.dart';
import 'package:temp_noti/src/widgets/detail/temp_info.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    bool isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isTablet ? 80 : 70),
        child: CustomAppbar(
          titleInfo: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, size: isTablet ? 40 : 30, color: Colors.white60),
              ),
              Text(
                arguments['name'],
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    custom_route.Route.setup,
                    arguments: {'serial': arguments['serial']},
                  );
                },
                icon: Icon(
                  Icons.settings,
                  size: isTablet ? 40 : 30,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: ConstColor.bgColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TempInfo(devSerial: arguments['serial']),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loc : ${arguments['loc']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 8),
                        Text('TempMin : ${arguments['tempMin']}',
                            style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 8),
                        Text('TempMax : ${arguments['tempMax']}',
                            style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status : ${arguments['status'] ? "อุณหภูมิเกิน" : "ปกติ"}',
                        style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text('HumiMin : ${arguments['humMin']}', style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 8),
                      Text('HumiMax : ${arguments['humMax']}', style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(child: DetailInfo(serial: arguments['serial'])),
            ],
          ),
        ),
      ),
    );
  }
}
