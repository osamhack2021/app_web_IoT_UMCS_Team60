import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/form/form_login.dart';
import 'package:ucms/page_login/register_page.dart';
import 'package:ucms/page_user/user_main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prefs = Get.find<SharedPreferences>();

    //이미 로그인 되어있으면 용사 메인으로 뛰어넘기
    if(prefs.getBool("islogin")==true) {
      Get.off(UserMain(location : prefs.getString("location")!, state : prefs.getString("state")!));
      return Container();
    }

    //최초 로그인 시
    else {
      return MaterialApp(
      home: KScreen(
          child: ListView (
            // ignore: prefer_const_literals_to_create_immutables
            children : [
              const SizedBox(height:100),
                title("login"),
                FormLogin(),
                PageButton(onPressed: (){
                  Get.to(const RegisterPage());
                },label: "전입 신병 가입"),
            ],
          ),
      ),
    );
    }
  }
}


