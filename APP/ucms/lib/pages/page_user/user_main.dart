// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/background/background_manager.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/position.dart';
import 'package:ucms/data/position_list.dart';
import 'package:ucms/pages/page_login/login_page.dart';
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/pages/page_user/user_move.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/utils/user_util/user_controller.dart';

class UserMain extends StatefulWidget {
  UserMain({Key? key, this.location, this.state}) : super(key: key);

  String? location = "location uninitialized";
  String? state = "state uninitialized";

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  final store = GetStorage();
  UserController u = Get.find<UserController>();
  BackgroundManager backMan = Get.find<BackgroundManager>();

  int selectedIndex = 1;
  bool firstSnack = true;

  @override
  void initState() {
    super.initState();
    // var beaconMan = Get.find<BeaconManager>();
    // var socketClient = Get.find<UserSocketClient>();
    // var beaconResult = beaconMan.beaconResult;
    // int min15 = 900;

    // beaconMan.startListeningBeacons();
    // Timer.periodic(const Duration(minutes: 2), (timer) {
    //   if (min15 >= 0) {
    //     socketClient.locationReport(
    //         macAddress: beaconResult.macAddress,
    //         scanTime: beaconResult.scanTime);
    //     min15 -= 120;
    //   } else {
    //     timer.cancel();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name = store.read("name") ?? "모름";
    widget.location = store.read("recent_place_name") ?? "위치 모름";
    widget.state = store.read("state");
    if (firstSnack) Snack.top("로그인 성공", "$name 으로 로그인됨");
    firstSnack = false;

    //backMan.man.registerPeriodicTask("1", "refresh_beacon");

    bool assembleVisible = store.read("assemble_visible") ?? false;

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    List<Position> positions = Get.find<PositionList>().list;
    bool _expanded = false;

    List<Widget> widgetOptions = <Widget>[
      Column(
        children: [
          topMargin(),
          title("모니터링"),
          quote("사용자들의 위치를 파악합니다"),
          const SizedBox(height: 20),
          ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 2000),
            children: [
              ...List<ExpansionPanel>.generate(positions.length, (index){
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(positions[index].name, style: body(),),
                    );
                  },
                  body: positions[index].toListTile(),
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                );
              }),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _expanded = !_expanded;
              setState(() {
 
              });
            },
        ),
          footer(),
        ],
      ),
      ListView(
        children: [
          topMargin(),
          title("UMCS"),
          quote("Untact Movement Control System"),
          const SizedBox(height: 20),
          LabelText(label: "현 위치", content: widget.location!),
          LabelText(label: "현 상태", content: widget.state!),
          Visibility(
            visible: assembleVisible,
            child: WarnButton(
                onPressed: () {
                  Get.to(
                      UserAssemble(location: store.read("assemble_location")));
                },
                label: "소집 지시가 내려왔습니다."),
          ),
          PageButton(
              onPressed: () {
                Get.to(const UserMove());
              },
              label: "이동 보고 하기"),
          footer(),
        ],
      ),
      ListView(
        children: [
          topMargin(),
          title("프로필"),
          quote("내 사용자 정보"),
          const SizedBox(height: 20),
          quote("$name 님 환영합니다."),
          PageButton(
              onPressed: () {
                u.logout();
                Get.to(LoginPage());
              },
              label: "로그아웃하기"),
          footer(),
        ],
      ),
    ];

    return MaterialApp(
      home: KScreen(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              name = store.read("name")??"모름";
              widget.location = store.read("location");
              widget.state = store.read("state");
              assembleVisible = store.read("assemble_visible");
            });
          },
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              label: 'Monitoring',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'My Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: selectedColor(),
          onTap: _onItemTapped,
          elevation: 5,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
