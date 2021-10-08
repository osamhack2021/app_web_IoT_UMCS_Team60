// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';

class UserAssemble extends StatelessWidget {
  UserAssemble({Key? key, required this.location, required this.timestamp}) : super(key: key);

  String location;
  DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
          child: ListView(
            children: [
              topMargin(),
              title("소집 지시"),
              const SizedBox(height: 20),
              const Image( image: AssetImage('assets/undraw_Notify.png'),fit : BoxFit.cover,),
              Text("소집 장소", style : h2(), textAlign: TextAlign.center,),
              Text(location, style : h1(), textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              Text("빠르게 모이십시오", style : warning(), textAlign : TextAlign.center),
              PageButton(onPressed:(){},label:"소집 불가합니다."),
              footer(),
            ],
          ),
      ),
    );
  }
}
