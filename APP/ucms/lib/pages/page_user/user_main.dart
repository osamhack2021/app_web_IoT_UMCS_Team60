// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/background/background_manager.dart';
import 'package:ucms/beacon/beacon_manager.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/position_list.dart';
import 'package:ucms/pages/page_cohort/cohort_main.dart';
import 'package:ucms/pages/page_login/login_page.dart';
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/pages/page_user/user_move.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/place_util/place_controller.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/utils/user_util/user_controller.dart';

class UserMain extends StatefulWidget {
  UserMain({Key? key, this.location, this.state, this.positions})
      : super(key: key);

  String? location = "location uninitialized";
  String? state = "state uninitialized";
  PositionList? positions = PositionList();
  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  final store = GetStorage();
  UserController u = Get.find<UserController>();
  BackgroundManager backMan = Get.find<BackgroundManager>();
  PlaceController p = Get.find<PlaceController>();

  int selectedIndex = 1;
  bool firstSnack = true;

  @override
  void initState() {
    super.initState();
    var beaconMan = Get.find<BeaconManager>();
    var socketClient = Get.find<UserSocketClient>();
    var beaconResult = beaconMan.beaconResult;
    int min15 = 900;

    beaconMan.startListeningBeacons();
    Timer.periodic(const Duration(minutes: 2), (timer) {
      if (min15 >= 0) {
        socketClient.locationReport(
            macAddress: beaconResult.macAddress,
            scanTime: beaconResult.scanTime);
        min15 -= 120;
      } else {
        timer.cancel();
      }
    });
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
    if (firstSnack) Snack.top("평시 상황", "$name 님으로 로그인되었습니다.");
    firstSnack = false;

    backMan.man.registerPeriodicTask("1", "refresh_beacon");

    bool assembleVisible = store.read("assemble_visible") ?? false;

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    List<bool> _expanded =
        List<bool>.generate(widget.positions!.list.length, (index) {
      return false;
    });

    List<Widget> widgetOptions =
        _buildPages(widget.positions!.list, _expanded, assembleVisible, name);

    return MaterialApp(
      home: KScreen(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() async {
              await u.currentPosition(store.read("tag"));
              await p.positionAllInfo();

              name = store.read("name") ?? "모름";
              widget.location = store.read("location");
              widget.state = store.read("state");
              assembleVisible = store.read("assemble_visible");
              widget.positions = await p.positionAllInfo();
              _expanded =
                  List<bool>.generate(widget.positions!.list.length, (index) {
                return true;
              });
              widgetOptions = _buildPages(
                  widget.positions!.list, _expanded, assembleVisible, name);
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

  List<Widget> _buildPages(positions, _expanded, assembleVisible, name) {
    return <Widget>[
      ListView(
        children: [
          topMargin(),
          title("모니터링"),
          quote("사용자들의 위치를 파악합니다"),
          quote("갯수 : ${positions.length}"),
          const SizedBox(height: 20),
          ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 2000),
            children: [
              ...List<ExpansionPanel>.generate(positions.length, (index) {
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(
                        positions[index].name,
                        style: body(),
                      ),
                    );
                  },
                  //body: positions[index].toListTile(),
                  body : const Text("Weeee"),
                  isExpanded: _expanded[index],
                  canTapOnHeader: true,
                );
              }),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _expanded[panelIndex] = !isExpanded;
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          PageButton(
              onPressed: () {
                u.logout();
                Get.to(LoginPage());
              },
              label: "로그아웃하기"),
          WarnButton(
              onPressed: () async{
                store.writeIfNull("state", "정상");
                      
                await u.currentPosition(store.read("tag"));
                positions = await p.positionAllInfo();

                Snack.top("로그인 시도", "성공");
                Get.to(CohortMain(
                  location: store.read("recent_place_name") ??
                      "error in LoginPage",
                  state: store.read("state") ?? "",
                  positions : positions,
                ));
              },
              label: "코호트 상황 메인 가기"),
          footer(),
        ],
      ),
    ];
  }
}
