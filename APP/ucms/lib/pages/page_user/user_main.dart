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
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/pages/page_user/user_move.dart';
import 'package:ucms/theme/size.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name = store.read("name") ?? "모름";
    widget.location = store.read("location");
    widget.state = store.read("state");
    Get.snackbar("로그인 성공", "$name 으로 로그인됨");

    backMan.man.registerPeriodicTask("1", "refresh_beacon");

    bool assembleVisible =false;

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return MaterialApp(
      home: KScreen(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              widget.location = store.read("location");
              widget.state = store.read("state");
            });
          },

          child: ListView(
            children: [
              topMargin(),
              title("UMCS"),
              quote("Untact Movement Control System"),
              const SizedBox(height: 20),
              LabelText(label: "현 위치", content: widget.location!),
              LabelText(label: "현 상태", content: widget.state!),
              Visibility(
                visible: assembleVisible,
                child: PageButton(onPressed: (){
                  Get.to(UserAssemble(location: store.read("assemble_location"), timestamp: store.read("assemble_time")));
                }, label: "소집 지시 페이지"),
              ),
              PageButton(
                  onPressed: () {
                    Get.to(const UserMove());
                  },
                  label: "이동 보고 하기"),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
