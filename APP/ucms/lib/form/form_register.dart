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
          const LabelFormInput(label: "id", hint: "id"),
          const LabelFormInput(label: "pw", hint: "pw"),
          const LabelFormInput(label: "pw check", hint: "re-enter pw"),
          const LabelFormInput(label: "division", hint: "division"),
          PostButton(onPressed: (){},label : "전입 등록 신청"),
        ],
      ),
    );
  }
}

