// ignore_for_file: prefer_initializing_formals, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/label_text.dart';

class UserMain extends StatelessWidget {
  UserMain({required String location, required String state}){
    this.location =location;
    this.state = state;
  }

  String location="막사-초기";
  String state="막사 대기중 - 초기";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints(maxWidth: 360, maxHeight: 800),
          child: Align(
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 100),
                const Text("용사 메인",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                LabelText(label: "현 위치", content: location),
                LabelText(label: "현 상태", content: state),
                TextButton(
                  onPressed: () {},
                  child: const Text("이동 보고하기", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
