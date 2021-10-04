

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';

// ignore: must_be_immutable
class FormMove extends StatelessWidget {
  FormMove({Key? key}) : super(key: key) {
    selected = {
      "막사": btns![0].selected,
      "체단실": btns![1].selected,
      "노래방": btns![2].selected,
      "지통실": btns![3].selected,
      "사지방": btns![4].selected,
      "도서관": btns![5].selected,
    };
  }

  final _formKey = GlobalKey<FormState>();
  final etcController = TextEditingController();
  String destination = "";
  Map<String, bool>? selected;

  List<ChoiceButton>? btns = [
    ChoiceButton(label: "막사"),
    ChoiceButton(label: "체단실"),
    ChoiceButton(label: "노래방"),
    ChoiceButton(label: "지통실"),
    ChoiceButton(label: "사지방"),
    ChoiceButton(label: "도서관"),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ChoiceButtonGroup(
            buttons: btns,
          ),
        ],
      ),
    );
  }
}
