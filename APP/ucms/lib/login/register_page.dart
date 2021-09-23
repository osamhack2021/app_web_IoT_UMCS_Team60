import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/form/form_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: KScreen(
            child : ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 100),
              title("Register"),
              FormRegister(),
              PostButton(onPressed: (){
                Navigator.pop(context);
              },label : "전입 등록 신청"),
            ],
          ),
      ),
    );
  }
}
