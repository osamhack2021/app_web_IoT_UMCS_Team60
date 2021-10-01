import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/form/form_login.dart';
import 'package:ucms/pages/page_login/register_page.dart';
import 'package:ucms/pages/page_user/user_main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    GetStorage prefs = Get.find<GetStorage>();

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
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 100),
              title("login"),
              FormLogin(),
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
