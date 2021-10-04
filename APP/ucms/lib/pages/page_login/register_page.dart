import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/form/form_register.dart';
import 'package:ucms/pages/page_login/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController tagCon = TextEditingController();
  final TextEditingController pwCon = TextEditingController();
  final TextEditingController pwCheckCon = TextEditingController();
  final TextEditingController divisionCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 100),
            title("Register"),
            FormRegister(
              tagCon: tagCon,
              pwCon: pwCon,
              pwCheckCon: pwCheckCon,
              divisionCon: divisionCon,
            ),
            PostButton(
                onPressed: () {
                  Get.to(const LoginPage());
                },
                label: "전입 등록 신청"),
          ],
        ),
      ),
    );
  }
}
