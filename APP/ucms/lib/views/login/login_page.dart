// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/views/cohort/cohort_main.dart';
import 'package:ucms/views/components/custom_buttons.dart';
import 'package:ucms/views/components/custom_screen.dart';
import 'package:ucms/views/components/texts.dart';
import 'package:ucms/views/login/register_page.dart';
import 'package:ucms/views/user/user_main.dart';
import 'package:ucms/views/theme/size.dart';
import 'package:ucms/controllers/cohort_controller.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/controllers/user_controller.dart';
import 'package:ucms/utils/validate.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _tag = TextEditingController();
  final _password = TextEditingController();

  final UserController u = Get.find<UserController>();
  final CohortController c = Get.find<CohortController>();

  @override
  Widget build(BuildContext context) {
    var prefs = GetStorage();
    prefs.writeIfNull("state", "정상");

    //이미 로그인 되어있을 시
    if (u.isLogin.value) {
      Get.offAll(UserMain(
        location: prefs.read("location") ?? "adsf",
        state: prefs.read("state") ?? "asdfafsd",
      ));
      return Container();
    }

    //최초 로그인 시
    else {
      return KScreen(
        child: ListView(
          children: [
            topMargin(),
            title("로그인"),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  KTextFormField(
                    controller: _tag,
                    validator: validateId(),
                    hint: "군번",
                  ),
                  KTextFormField(
                    controller: _password,
                    validator: validatePw(),
                    obscureText: true,
                    hint: "password",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            PageButton(
              label: "용사 로그인",
              onPressed: () async {
                final store = GetStorage();
                if (_formKey.currentState!.validate()) {
                  String result =
                      await u.login(_tag.text.trim(), _password.text.trim());
                  if (result == "success") {
                    store.write("state", "정상");

                    await u.currentPosition(_tag.text.trim());

                    if (c.isCohort.value) {
                      Snack.top("로그인 시도", "성공");
                      Get.offAll(CohortMain(
                        location: store.read("recent_place_name") ??
                            "error in LoginPage",
                        state: store.read("state") ?? "",
                      ));
                    } else {
                      Snack.top("로그인 시도", "성공");
                      Get.offAll(UserMain(
                        location: store.read("recent_place_name") ??
                            "error in LoginPage",
                        state: store.read("state") ?? "",
                      ));
                    }
                  } else {
                    Snack.top("로그인 시도", result);
                  }
                }
              },
            ),
            PageButton(
                onPressed: () {
                  Get.to(RegisterPage());
                },
                label: "전입 신병 가입"),
            footer(),
          ],
        ),
      );
    }
  }
}