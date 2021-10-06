// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';

class UserMain extends StatelessWidget {
  UserMain({Key? key, this.location, this.state}) : super(key: key);

  RxString? location="location uninitialized".obs;
  RxString? state="state uninitialized".obs;

  @override
  Widget build(BuildContext context) {
    final store = GetStorage();
    String name = store.read("name")??"모름";
    location = store.read("location");
    state = store.read("state");
    Get.snackbar("로그인 성공", "$name 으로 로그인됨");

    return MaterialApp(
      home: KScreen(
          child: Obx(
            ()=>ListView(
              children: [
                const SizedBox(height: 100),
                title("용사 메인"),
                const SizedBox(height: 20),
                LabelText(label: "현 위치", content: location!.value),
                LabelText(label: "현 상태", content: state!.value),
                PageButton(onPressed:(){
                  Navigator.pushNamed(context, "/user/move");
                },label:"이동 보고 하기"),
              ],
            ),
          ),
        ),
    );
  }
}
