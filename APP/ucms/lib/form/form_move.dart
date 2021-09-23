// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';

class FormMove extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    List<ChoiceButton>? btns = [
      ChoiceButton(label: "막사"),
      ChoiceButton(label: "체단실"),
      ChoiceButton(label: "노래방"),
      ChoiceButton(label: "지통실"),
      ChoiceButton(label: "사지방"),
      ChoiceButton(label: "도서관"),
      ];
    return  Form(
      key : _formKey,
      child :Column(
        children : [
          ChoiceButtonGroup(buttons: btns,),

        ],
      ),
    );
  }
}

