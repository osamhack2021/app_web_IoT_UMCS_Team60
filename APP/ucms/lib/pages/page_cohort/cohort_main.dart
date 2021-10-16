// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/beacon/beacon_manager.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/expan_item.dart';
import 'package:ucms/data/places/place.dart';
import 'package:ucms/data/position_list.dart';
import 'package:ucms/pages/page_cohort/cohort_assemble.dart';
import 'package:ucms/pages/page_cohort/cohort_move.dart';
import 'package:ucms/pages/page_login/login_page.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/cohort_util/cohort_controller.dart';
import 'package:ucms/utils/place_util/place_controller.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/utils/user_util/user_controller.dart';
import 'package:ucms/utils/validate.dart';

class CohortMain extends StatefulWidget {
  CohortMain({Key? key, this.location, this.state, this.positions})
      : super(key: key);

  String? location = "location uninitialized";
  String? state = "state uninitialized";
  List<PositionList>? positions = [];
  @override
  State<CohortMain> createState() => _CohortMainState();
}

class _CohortMainState extends State<CohortMain> {
  final store = GetStorage();
  UserController u = Get.find<UserController>();
  PlaceController p = Get.find<PlaceController>();
  CohortController c = Get.isRegistered<CohortController>()? Get.find<CohortController>():Get.put(CohortController());
  
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  final nameCon = TextEditingController(); 
  final rankCon= TextEditingController();
  final timeCon= TextEditingController();
  final tempCon= TextEditingController(); 
  final descCon= TextEditingController();

  int selectedIndex = 2;
  bool firstSnack = true;

  List<ExpanItem> expanItems=[];

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
        socketClient.getIn(
            macAddress: beaconResult.macAddress,
        );
        min15 -= 2;
      } else {
        timer.cancel();
      }
    });
    expanItems=
        List<ExpanItem>.generate(widget.positions!.length, (index) {
      return ExpanItem(expanded: false, header: widget.positions![index].place.name, body : widget.positions![index].toListTiles());
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
    if (firstSnack) Snack.warnTop("코호트 상황", "$name 님으로 로그인되었습니다.");
    firstSnack = false;

    bool assembleVisible = store.read("assemble_visible") ?? false;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    
    List<Widget> widgetOptions =_buildPages(c, positions : widget.positions!, expanItems : expanItems, 
         assembleVisible : assembleVisible,  name : name,  nameCon : nameCon , formKey : formKey,  
         rankCon : rankCon,  timeCon : timeCon,  tempCon : tempCon ,  descCon : descCon);

    

    return MaterialApp(
      home: KScreen(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() async {
              await u.currentPosition(store.read("tag"));
              await p.positionAllInfo();

              name = store.read("name") ?? "모름";
              widget.location = store.read("location");
              widget.state = store.read("state");
              assembleVisible = store.read("assemble_visible");
              widget.positions = await p.positionAllInfo();
              
              widgetOptions = _buildPages(c, positions : widget.positions!, expanItems : expanItems, 
         assembleVisible : assembleVisible,  name : name,  nameCon : nameCon , formKey : formKey,  
         rankCon : rankCon,  timeCon : timeCon,  tempCon : tempCon ,  descCon : descCon);
            });
          },
          child: widgetOptions.elementAt(selectedIndex),
        ),
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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _buildPages(CohortController c, {required List<PositionList> positions, required List<ExpanItem> expanItems, 
        required bool assembleVisible, required String name, required nameCon, required GlobalKey<FormState> formKey,  
        required rankCon, required timeCon, required tempCon, required descCon}) {
    DateTime _now = DateTime.now().toUtc().add(const Duration(hours: 9));
    return <Widget>[
      ListView(
        children: [
          topMargin(),
          title("공공시설 사용 인원 조회"),
          quote("사용자들의 위치를 파악합니다"),
          quote("갯수 : ${positions.length}"),
          const SizedBox(height: 20),
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
                  isExpanded: expanItems[index].expanded,
                  canTapOnHeader: true,
                );
              }),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                expanItems[panelIndex].expanded = !isExpanded;
              });
            },
          ),
         
          const SizedBox(height: 20),
          footer(),
        ],
      ),
       ListView(
        children: [
          topMargin(),
          title("공공시설 사용 시간표 조회"),
          quote("사용할 수 있는 시간을 파악합니다"),
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
                  isExpanded: expanItems[index].expanded,
                  canTapOnHeader: true,
                );
              }),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                expanItems[panelIndex].expanded = !isExpanded;
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
                      CohortAssemble(location: store.read("assemble_location")));
                },
                label: "소집 지시가 내려왔습니다."),
          ),
          WarnButton(
              onPressed: () async {
                List<Place> btns = await p.outsideFacilAllInfo();
                Get.to(CohortMove(name : "외부시설", btns: btns));
              },
              label: "외부시설 사용 요청 하기"),
          WarnButton(
              onPressed: () async {
                List<Place> btns = await p.doomFacilAllInfo();
                Get.to(CohortMove(name : "건물 내", btns: btns));
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
                  LabelFormDropDown(label: "계급", labels : const ["훈련병","이병","일병","상병","병장"], hint: "계급",controller: rankCon, validator: validateNull(),isCohort: true,),
                  LabelFormInput(label: "이름", hint: "이름",controller: nameCon, validator: validateNull(),isCohort: true,),
                  LabelFormDateTimeInput(label: "현재 시간", hint: "${_now.hour}:${_now.minute}", controller: timeCon, validator: validateTime(),isCohort: true,),
                  LabelFormFloatInput(label: "현재 체온", hint: "36.5",controller: tempCon, validator: validateNull(),isCohort: true,),
                  LabelFormInput(label: "이상 유무", hint: "자유롭게 입력",controller: descCon, validator: validateNull(),isCohort: true,),
                ],
              ),
            ),
            const SizedBox(height: 20),
            WarnButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var json = {
                      "temperature" : tempCon.text.trim(),
                      "details" : descCon.text.trim(),
                    };
                    String result = await c.anomaly(json);
                    if (result =="success") {
                      Get.back();
                      Snack.top("이상 유무 보고 시도", "성공");
                    } else {Snack.warnTop("이상 유무 보고 시도", result);}
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
          quote("$name 님 환영합니다."),
          const SizedBox(height: 20),
          WarnButton(
              onPressed: () {
                u.logout();
                Get.to(LoginPage());
              },
              label: "로그아웃하기"),
           PageButton(
              onPressed: () async{
                store.writeIfNull("state", "정상");
                      
                await u.currentPosition(store.read("tag"));
                positions = await p.positionAllInfo();

                Get.to(UserMain(
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
