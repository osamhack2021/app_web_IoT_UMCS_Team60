// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umcs/views/components/custom_buttons.dart';
import 'package:umcs/services/beacon/beacon_manager.dart';
import 'package:umcs/views/components/custom_screen.dart';
import 'package:umcs/views/components/label.dart';
import 'package:umcs/views/components/texts.dart';
import 'package:umcs/model/expan_item.dart';
import 'package:umcs/model/places/place.dart';
import 'package:umcs/model/position_list.dart';
import 'package:umcs/model/time_list.dart';
import 'package:umcs/views/cohort/cohort_assemble.dart';
import 'package:umcs/views/cohort/cohort_move.dart';
import 'package:umcs/views/login/login_page.dart';
import 'package:umcs/views/user/user_main.dart';
import 'package:umcs/services/socket/user_socket_client.dart';
import 'package:umcs/views/theme/color_theme.dart';
import 'package:umcs/views/theme/size.dart';
import 'package:umcs/views/theme/text_theme.dart';
import 'package:umcs/controllers/cohort_controller.dart';
import 'package:umcs/controllers/place_controller.dart';
import 'package:umcs/utils/snackbar.dart';
import 'package:umcs/controllers/user_controller.dart';
import 'package:umcs/utils/validate.dart';

class CohortMain extends StatefulWidget {
  CohortMain({Key? key, this.location, this.state}) : super(key: key);

  String? location = "location uninitialized";
  String? state = "state uninitialized";
  @override
  State<CohortMain> createState() => _CohortMainState();
}

class _CohortMainState extends State<CohortMain> {
  final store = GetStorage();
  UserController u = Get.find<UserController>();
  PlaceController p = Get.find<PlaceController>();
  CohortController c = Get.find<CohortController>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameCon = TextEditingController();
  final rankCon = TextEditingController();
  final timeCon = TextEditingController();
  final tempCon = TextEditingController();
  final descCon = TextEditingController();

  int selectedIndex = 2;
  bool firstSnack = true;

  List<ExpanItem> expanItemsPos = [];
  List<ExpanItem> expanItemsTimes = [];

  @override
  void initState() {
    super.initState();
    var beaconMan = Get.find<BeaconManager>();
    UserSocketClient socketClient = Get.find<UserSocketClient>();
    socketClient.startSocket(store.read("token"));
    var beaconResult = beaconMan.beaconResult;
    int min15 = 900;

    beaconMan.startListeningBeacons();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (min15 >= 0) {
        
        double resultProximity = 0;
        try {
          resultProximity = beaconResult.proximity;
        } catch (e) {debugPrint(e.toString());}

        socketClient.locationReport(
            macAddress: beaconResult.macAddress, proximity: resultProximity);

        min15 -= 2;
      } else {
        timer.cancel();
      }
    });
    expanItemsPos = List<ExpanItem>.generate(p.positions.length, (index) {
      return ExpanItem(
          expanded: false,
          header: p.positions[index].place.name,
          body: p.positions[index].toListTiles());
    });
    expanItemsTimes = List<ExpanItem>.generate(c.times.length, (index) {
      return ExpanItem(
          expanded: false,
          header: c.times[index].place.name,
          body: c.times[index].toListTiles());
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
    
    firstSnack = false;

    bool assembleVisible = store.read("assemble_visible") ?? false;

    List<Widget> widgetOptions = _buildPages(c,
        positions: p.positions,
        expanItemsPos: expanItemsPos,
        times: c.times,
        expanItemsTimes: expanItemsPos,
        assembleVisible: assembleVisible,
        name: name,
        nameCon: nameCon,
        formKey: formKey,
        rankCon: rankCon,
        timeCon: timeCon,
        tempCon: tempCon,
        descCon: descCon);

    return KScreen(
      child: widgetOptions.elementAt(selectedIndex),
      bottomBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: '사용 인원 조회',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_busy),
            label: '사용 시간표',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: '체온 보고',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '내 프로필',
          ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: warningColor(),
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _buildPages(CohortController c,
      {required List<PositionList> positions,
      required List<ExpanItem> expanItemsPos,
      required List<TimeList> times,
      required List<ExpanItem> expanItemsTimes,
      required bool assembleVisible,
      required String name,
      required nameCon,
      required GlobalKey<FormState> formKey,
      required rankCon,
      required timeCon,
      required tempCon,
      required descCon}) {
    DateTime _now = DateTime.now().toUtc().add(const Duration(hours: 9));
    return <Widget>[
      Obx(
        () => ListView(
          children: [
            topMargin(),
            title("공공시설 사용 인원 조회"),
            quote("사용자들의 위치를 파악합니다"),
            const SizedBox(height: 50),
            ExpansionPanelList(
              //TODO : ExpansionTile 로 공간 종류마다 나누기.
              animationDuration: const Duration(milliseconds: 2000),
              children: [
                ...List<ExpansionPanel>.generate(positions.length, (index) {
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          "${positions[index].place.name} (${positions[index].list.length} 명)",
                          style: body(),
                        ),
                      );
                    },
                    body: positions[index].toListTiles(),
                    isExpanded: expanItemsPos[index].expanded,
                    canTapOnHeader: true,
                  );
                }),
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  expanItemsPos[panelIndex].expanded = !isExpanded;
                });
              },
            ),
            const SizedBox(height: 20),
            footer(),
          ],
        ),
      ),
      Obx(
        () => ListView(
          children: [
            topMargin(),
            title("공공시설 사용 시간표 조회"),
            quote("사용할 수 있는 시간을 파악합니다"),
            const SizedBox(height: 50),
            ExpansionPanelList(
              //TODO : ExpansionTile 로 공간 종류마다 나누기.
              animationDuration: const Duration(milliseconds: 2000),
              children: [
                ...List<ExpansionPanel>.generate(times.length, (index) {
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(
                          "${times[index].place.name} 시간표",
                          style: body(),
                        ),
                      );
                    },
                    body: times[index].toListTiles(),
                    isExpanded: expanItemsTimes[index].expanded,
                    canTapOnHeader: true,
                  );
                }),
              ],
              dividerColor: Colors.grey,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  expanItemsTimes[panelIndex].expanded = !isExpanded;
                });
              },
            ),
            footer(),
          ],
        ),
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
                  Get.to(CohortAssemble(
                      location: store.read("assemble_location")));
                },
                label: "소집 지시가 내려왔습니다."),
          ),
          WarnButton(
              onPressed: () async {
                List<Place> btns = await p.outsideFacilAllInfo();
                Get.to(CohortMove(name: "외부시설", btns: btns));
              },
              label: "외부시설 사용 요청 하기"),
          WarnButton(
              onPressed: () async {
                List<Place> btns = await p.doomFacilAllInfo();
                Get.to(CohortMove(name: "건물 내", btns: btns));
              },
              label: "건물 내 사용 요청 하기"),
          footer(),
        ],
      ),
      ListView(
        children: [
          topMargin(),
          title("체온측정 및 이상유무 보고"),
          quote("내 건강상태를 보고합니다."),
          const SizedBox(height: 40),
          Form(
            key: formKey,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
            
                LabelFormFloatInput(
                  label: "현재 체온",
                  hint: "36.5",
                  controller: tempCon,
                  validator: validateNull(),
                  isCohort: true,
                ),
                LabelFormInput(
                  label: "이상 유무",
                  hint: "자유롭게 입력",
                  controller: descCon,
                  validator: validateNull(),
                  isCohort: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          WarnButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var json = {
                    "temperature": tempCon.text.trim(),
                    "details": descCon.text.trim(),
                  };
                  String result = await c.anomaly(json);
                  if (result == "success") {
                    Get.back();
                    Snack.top("이상 유무 보고 시도", "성공");
                  } else {
                    Snack.warnTop("이상 유무 보고 시도", result);
                  }
                }
              },
              label: "이상 유무 보고"),
          footer(),
        ],
      ),
      ListView(
        children: [
          topMargin(),
          title("프로필"),
          quote("내 사용자 정보"),
          const SizedBox(height: 20),
          const Icon(
            Icons.account_circle,
            size: 100.0,
          ),
          quote("$name 님 환영합니다."),
          const SizedBox(height: 20),
          WarnButton(
              onPressed: () {
                u.logout();
                Get.offAll(LoginPage());
              },
              label: "로그아웃하기"),
          PageButton(
              onPressed: () async {
                store.writeIfNull("state", "정상");

                await u.currentPosition(store.read("tag"));
                // await p.positionAllInfo();

                Get.to(UserMain(
                  location:
                      store.read("recent_place_name") ?? "error in LoginPage",
                  state: store.read("state") ?? "",
                ));
              },
              label: "코호트 상황 메인 가기"),
          footer(),
        ],
      ),
    ];
  }
}