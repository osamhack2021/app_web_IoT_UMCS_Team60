

import 'package:flutter/material.dart';
import 'package:ucms/components/label.dart';

class FormRegister extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();

  FormRegister({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Form(
      key : _formKey,
      child :Column(
        // ignore: prefer_const_literals_to_create_immutables
        children : [
          const LabelFormInput(label: "id", hint: "id"),
          const LabelFormInput(label: "pw", hint: "pw"),
          const LabelFormInput(label: "pw check", hint: "re-enter pw"),
          const LabelFormInput(label: "division", hint: "division"),
        ],
      ),
    );
  }
}

