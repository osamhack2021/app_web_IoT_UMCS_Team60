import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/pages/page_login/register_page.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/utils/user_util/user_controller.dart';
import 'package:ucms/utils/validate.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _tag = TextEditingController();
  final UserController u = Get.put(UserController());
  final _password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var prefs = GetStorage();

    //이미 로그인 되어있을 시
    if (prefs.read("islogin") == true) {
      Get.off(UserMain(
          location: prefs.read("location")!, state: prefs.read("state")!));
      return Container();
    }

    //최초 로그인 시
    else {
      return MaterialApp(
        home: KScreen(
          child: ListView(
            children: [
              const SizedBox(height: 100),
              title("login"),
               Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _tag,
                      validator: validateId(),
                      decoration: const InputDecoration(hintText: "군번"),
                    ),
                    TextFormField(
                      controller: _password,
                      validator: validatePw(),
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "password"),
                    ),
                  ],
                ),
              ),
              PageButton(
              label: "용사 로그인",
              onPressed: () async {
                final store = GetStorage();
                if (_formKey.currentState!.validate()) {
                  int result =
                      await u.login(_tag.text.trim(),_password.text.trim());
                  if (result == 1) {
                    Get.to(UserMain(
                          location: store.read("location")??"location",
                          state: store.read("state")??"location",
                        ));
                  } else {Get.snackbar("로그인 시도", "로그인 실패");}
                }
              },
            ),
              PageButton(
                  onPressed: () {
                    Get.to(RegisterPage());
                  },
                  label: "전입 신병 가입"),
            ],      
          ),
          ),
      );
    }
  }
}
