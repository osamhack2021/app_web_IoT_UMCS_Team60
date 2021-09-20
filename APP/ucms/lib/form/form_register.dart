// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/label.dart';

class FormRegister extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return  Form(
      key : _formKey,
      child :Column(
        children : [
          const LabelInput(label: "id", hint: "id"),
          const LabelInput(label: "pw", hint: "pw"),
          const LabelInput(label: "pw check", hint: "re-enter pw"),
          const LabelInput(label: "division", hint: "division"),
          PostButton(onPressed: (){},label : "전입 등록 신청"),
        ],
      ),
    );
  }
}

