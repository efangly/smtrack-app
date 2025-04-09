import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:temp_noti/src/constants/color.dart';
import 'package:temp_noti/src/services/services.dart';
import 'package:temp_noti/src/widgets/setting/probe_adj.dart';
import 'package:temp_noti/src/widgets/utils/appbar.dart';
import 'package:temp_noti/src/widgets/utils/snackbar.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  bool isTablet = false;
  late final TextStyle tabTextStyle;
  final List<Widget> tab = [];
  final List<Widget> tabView = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isTablet = MediaQuery.of(context).size.width > 720 ? true : false;
      if (isTablet) {
        tabTextStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
      } else {
        tabTextStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final api = Api();
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
                  "ตั้งค่าโพรบ",
                  style: TextStyle(fontSize: isTablet ? 25 : 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: isTablet ? 40 : 30,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: ConstColor.bgColor,
          child: FutureBuilder(
            future: api.getDeviceById(arguments['serial']),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถโหลดข้อมูลได้");
                Navigator.pop(context);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white70));
              }
              if (snapshot.hasData) {
                _tabController = TabController(length: snapshot.data!.probe!.length, vsync: this);
                for (int i = 0; i < snapshot.data!.probe!.length; i++) {
                  tab.add(Tab(text: 'โพรบ ${snapshot.data!.probe![i].channel}'));
                  tabView.add(ProbeAdj(probe: snapshot.data!.probe![i], isTablet: isTablet));
                }
                return Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.white70,
                      unselectedLabelColor: Colors.white54,
                      dividerColor: Colors.white70,
                      indicatorColor: Colors.white60,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 3,
                      labelStyle: tabTextStyle,
                      tabs: tab,
                    ),
                    Expanded(child: TabBarView(controller: _tabController, children: tabView)),
                  ],
                );
              }
              return const Center(child: Text("ไม่พบข้อมูล"));
            },
          ),
        ));
  }
}
