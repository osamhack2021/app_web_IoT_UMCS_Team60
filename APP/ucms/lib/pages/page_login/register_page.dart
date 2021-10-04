import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/pages/page_login/login_page.dart';
import 'package:ucms/utils/user_util/user_controller.dart';
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
            const SizedBox(height: 100),
            title("Register"),
            Form(
              key: _formKey,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  LabelFormInput(label: "tag",hint: "군번",controller: _tag,validator: validateId(),),
                  LabelFormInput(label: "pw", hint: "비밀번호",controller: _pw, validator: validatePw()),
                  LabelFormInput(label: "pw check", hint: "비밀번호 다시 입력",controller: _pwCheck, validator: validatePwCheck(value : _pw.text.trim(), checkValue : _pwCheck.text.trim()),),
                  LabelFormInput(label: "name", hint: "이름",controller: _name, validator: validateNull(),),
                  LabelFormDropDown(label: "rank", labels : const ["훈련병","이병","일병","병장"], hint: "계급",controller: _rank, validator: validateNull(),),
                  LabelFormIntInput(label: "roomId", hint: "생활실 번호",controller: _roomId, validator: validateNull(),),
                  LabelFormIntInput(label: "doomId", hint: "생활관 번호",controller: _doomId, validator: validateNull(),),
                  LabelFormInput(label: "department", hint: "소속 부대",controller: _department, validator: validateNull(),),
                ],
              ),
            ),
            PostButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    int result =
                        await u.register(
                          tag : _tag.text.trim(),
                          password : _pw.text.trim(),
                          name : _name.text.trim(),
                          rank : _rank.text.trim(),
                          roomId: _roomId.value,
                          doomId: _doomId.value,
                          department : _department.text.trim(),
                        );
                    if (result == 1) {
                      Get.to(()=>LoginPage());
                    } else {Get.snackbar("회원가입 시도", "회원가입 실패");}
                  }                  
                },
              label: "전입 등록 신청"),
          ],
        ),
      ),
    );
  }
}
