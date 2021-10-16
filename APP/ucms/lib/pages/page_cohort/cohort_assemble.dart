// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/validate.dart';

class CohortAssemble extends StatefulWidget {
  CohortAssemble({Key? key, required this.location}) : super(key: key);

  String location;

  @override
  State<CohortAssemble> createState() => _CohortAssembleState();
}

class _CohortAssembleState extends State<CohortAssemble> {
  TextEditingController cannot = TextEditingController();

  RxBool visible = false.obs;
  String labelText="";
  String primaryText = "소집 불가합니다.";
  String emitText ="소집 불가 사유 전송";

  @override
  Widget build(BuildContext context) {
    labelText = primaryText;
    return MaterialApp(
      home: KScreen(
          child: ListView(
            children: [
              topMargin(),
              title("소집 지시"),
              const SizedBox(height: 20),
              const Image( image: AssetImage('assets/undraw_Notify.png'),fit : BoxFit.cover,),
              Text("소집 장소", style : h2(), textAlign: TextAlign.center,),
              Text(widget.location, style : h1(), textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              Text("빠르게 모이십시오", style : warning(), textAlign : TextAlign.center),
              
              Visibility(
                visible: visible.value,
                child: KTextFormField(hint: "사유를 입력하세요", controller: cannot, validator: validateNull())
              ),
              PageButton(onPressed:(){
                if(!visible.value) {
                  setState(() {
                      visible = true.obs;
                      labelText =emitText;
                  });
                }
                else {
                  UserSocketClient socket = Get.find<UserSocketClient>();
                  socket.cannotAssemble(description: cannot.text.trim());

                  Get.back();
                }
              },label:labelText),
              footer(),
            ],
          ),
      ),
    );
  }
}
