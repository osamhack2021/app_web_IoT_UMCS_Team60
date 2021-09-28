import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/form/form_move.dart';

class UserMove extends StatelessWidget {
  const UserMove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  KScreen(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 100),
              title("이동 보고"),
              FormMove(),
              PostButton(onPressed: (){
                Navigator.pop(context);
              },label: "보고"),
            ],
          ),
        ),
    );
  }
}


