// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';

class FormLogin extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return  Form(
      key : _formKey,
      child :Column(
        children : [
          const TextField(
            decoration: InputDecoration(hintText: "id"),
          ),
          const TextField(
            obscureText:true,
            decoration: InputDecoration(hintText: "password"),
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              PostButton(onPressed : (){},label: "용사 로그인"),
              PostButton(onPressed: (){},label: "간부 로그인"),
            ],
          ),
          PageButton(onPressed: (){},label: "전입 신병 가입"),
        ],
      ),
    );
  }
}

