import 'package:flutter/material.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/widgets/device/config_info.dart';
import 'package:temp_noti/src/widgets/device/temp_info.dart';

class DeviceInfomation extends StatefulWidget {
  final DeviceId device;
  final bool isTablet;
  const DeviceInfomation({super.key, required this.device, required this.isTablet});

  @override
  State<DeviceInfomation> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfomation> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextStyle tabTextStyle;
  final List<Widget> tab = [];
  final List<Widget> tabView = [];

  @override
  void initState() {
    super.initState();
    if (widget.isTablet) {
      tabTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    } else {
      tabTextStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    }
    _tabController = TabController(length: widget.device.probe!.length, vsync: this);
    for (int i = 0; i < widget.device.probe!.length; i++) {
      tab.add(Tab(text: 'โพรบ ${widget.device.probe![i].channel}'));
      tabView.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TempInfo(devSerial: widget.device.id!, probe: widget.device.probe![i].channel!),
            const SizedBox(height: 25),
            ConfigInfo(isTablet: widget.isTablet, probe: widget.device.probe![i]),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.white70,
          unselectedLabelColor: Colors.white54,
          dividerColor: Colors.white30,
          indicatorColor: Colors.white54,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,
          labelStyle: tabTextStyle,
          tabs: tab,
        ),
        Expanded(child: TabBarView(controller: _tabController, children: tabView)),
      ],
    );
  }
}
