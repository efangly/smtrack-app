import 'package:flutter/material.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/widgets/notification/notification_legacy.dart';
import 'package:temp_noti/src/widgets/notification/notification_list.dart';

class NotificationTab extends StatefulWidget {
  final List<HospitalData> hospital;
  final String role;
  final bool isTablet;
  const NotificationTab({super.key, required this.hospital, required this.role, required this.isTablet});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int tabLength = 1;
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
    switch (widget.role) {
      case "USER":
        tab.addAll([const Tab(text: 'eTEMP/iTemS')]);
        tabView.addAll([const SizedBox(child: NotificationList())]);
        break;
      case "LEGACY_USER":
        tab.addAll([const Tab(text: 'Line Notify')]);
        tabView.addAll([const SizedBox(child: NotificationLegacy())]);
        break;
      case "GUEST":
        tab.addAll([const Tab(text: 'eTEMP/iTemS')]);
        tabView.addAll([const SizedBox(child: NotificationList())]);
        break;
      case "SUPER":
        tab.addAll([const Tab(text: 'eTEMP/iTemS'), const Tab(text: 'Line Notify')]);
        tabView.addAll([
          const SizedBox(child: NotificationList()),
          const SizedBox(child: NotificationLegacy()),
        ]);
        tabLength = 2;
        break;
      case "SERVICE":
        tab.addAll([const Tab(text: 'eTEMP/iTemS'), const Tab(text: 'Line Notify')]);
        tabView.addAll([
          const SizedBox(child: NotificationList()),
          const SizedBox(child: NotificationLegacy()),
        ]);
        tabLength = 2;
        break;
      default:
        final List<Ward> wards = [];
        for (var hospital in widget.hospital) {
          wards.addAll(hospital.ward!);
        }
        final newWards = wards.where((ward) => ward.type == "NEW").toList();
        final legacyWards = wards.where((ward) => ward.type == "LEGACY").toList();
        if (newWards.isNotEmpty && legacyWards.isNotEmpty) {
          tabLength = 2;
          tab.addAll([const Tab(text: 'eTEMP/iTemS'), const Tab(text: 'Line Notify')]);
          tabView.addAll([
            const SizedBox(child: NotificationList()),
            const SizedBox(child: NotificationLegacy()),
          ]);
        } else {
          if (newWards.isNotEmpty) {
            tab.addAll([const Tab(text: 'eTEMP/iTemS')]);
            tabView.addAll([const SizedBox(child: NotificationList())]);
          } else {
            tab.addAll([const Tab(text: 'Line Notify')]);
            tabView.addAll([const SizedBox(child: NotificationLegacy())]);
          }
        }
        break;
    }
    _tabController = TabController(length: tabLength, vsync: this);
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
          dividerColor: Colors.white70,
          indicatorColor: Colors.white60,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          labelStyle: tabTextStyle,
          tabs: tab,
        ),
        Expanded(child: TabBarView(controller: _tabController, children: tabView)),
      ],
    );
  }
}
