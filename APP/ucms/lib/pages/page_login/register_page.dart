import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/controllers/user_controller.dart';
import 'package:ucms/utils/validate.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _tag = TextEditingController();
  final _pw = TextEditingController();
  final _pwCheck = TextEditingController();
  final _name = TextEditingController();
  final _rank = TextEditingController();
  final _roomId = TextEditingController();
  final _doomId = TextEditingController();
  final _department = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            topMargin(),
            title("회원가입"),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  LabelFormInput(label: "군번",hint: "군번(ex.20-70000000))",controller: _tag,validator: validateId(),),
                  LabelFormInput(label: "비밀번호", hint: "5자리 이상 입력",controller: _pw, validator: validatePw()),
                  LabelFormInput(label: "비밀번호 확인", hint: "비밀번호 다시 입력",controller: _pwCheck, 
                  validator: (data) {
                    return ((data==_pw.text.trim())?null:"비밀번호 입력한 값이 서로 다릅니다");
                  }),
                  LabelFormInput(label: "이름", hint: "이름",controller: _name, validator: validateNull(),),
                  LabelFormDropDown(label: "계급", labels : const ["훈련병","이병","일병","상병","병장"], hint: "계급",controller: _rank, validator: validateNull(),),
                  LabelFormIntInput(label: "생활실 번호", hint: "숫자로 입력",controller: _roomId, validator: validateNull(),),
                  LabelFormIntInput(label: "생활관 번호", hint: "숫자로 입력",controller: _doomId, validator: validateNull(),),
                  LabelFormInput(label: "소속 부대", hint: "중대급까지 입력",controller: _department, validator: validateNull(),),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PostButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var json = {
                      "tag": _tag.text.trim(), 
                      "password": _pw.text.trim(), 
                      "name": _name.text.trim(), 
                      "rank": _rank.text.trim(), 
                      "roomId": int.parse(_roomId.text),
                      "doomId": int.parse(_doomId.text), 
                      "department": _department.text.trim(),
                    };
                    String result = await u.register(json);
                    if (result =="success") {
                      Get.back();
                      Snack.top("회원가입 시도", "성공");
                    } else {Snack.bottom("회원가입 시도", result);}
                  }                  
                },
              label: "전입 등록 신청"),
            footer(),
          ],
        ),
      ),
    );
  }
}
