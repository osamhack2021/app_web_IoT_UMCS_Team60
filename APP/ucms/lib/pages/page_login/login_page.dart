import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/pages/page_login/register_page.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/utils/user_util/user_controller.dart';
import 'package:ucms/utils/validate.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _tag = TextEditingController();
  final UserController u = Get.isRegistered<UserController>()?Get.find<UserController>():Get.put(UserController());
  final _password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var prefs = GetStorage();
    //이미 로그인 되어있을 시
    if (u.isLogin.value) {
      Get.off(UserMain(
          location: prefs.read("location")??"adsf", state: prefs.read("state")??"asdfafsd"));
      return Container();
    }

    //최초 로그인 시
    else {
      return MaterialApp(
        home: KScreen(
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
              PageButton(
              label: "용사 로그인",
              onPressed: () async {
                final store = GetStorage();
                if (_formKey.currentState!.validate()) {
                  String result = await u.login(_tag.text.trim(),_password.text.trim());
                  if (result == "success") {
                    store.write("state", "정상");
                    var userJson = await u.userInfo(_tag.text.trim());
                    User user = User.fromJson(userJson);
                    User.updatePrefs(user);
                    
                    Get.to(UserMain(
                          location: store.read("location")??"",
                          state: store.read("state")??"",
                        ));
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
          ),
      );
    }
  }
}
