// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';

class FormMove extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    List<String> names = ["체단실", "식당"];
    return  Form(
      key : _formKey,
      child :Column(
        children : [
          ChoiceButtonGroup(onPressed: (){}, buttonNames: names),
          PostButton(onPressed: (){},label: "전입 신병 가입"),
        ],
      ),
    );
  }
}

