// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/label.dart';
import 'package:ucms/components/texts.dart';

class UserMain extends StatelessWidget {
  UserMain({Key? key, required this.location, required this.state}) : super(key: key);

  String location;
  String state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: KScreen(
          child: ListView(
            children: [
              const SizedBox(height: 100),
              title("용사 메인"),
              const SizedBox(height: 20),
              LabelText(label: "현 위치", content: location),
              LabelText(label: "현 상태", content: state),
              PageButton(onPressed:(){},label:"이동 보고 하기"),
            ],
          ),
        ),
      ),
    );
  }
}
