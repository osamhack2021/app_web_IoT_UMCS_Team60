// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class FormLogin extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return  Form(
      key : _formKey,
      child :Column(
        children : [
          TextFormField(
            decoration: const InputDecoration(hintText: "id"),
          ),
          TextFormField(
            obscureText:true,
            decoration: const InputDecoration(hintText: "password"),
          ),
        ],
      ),
    );
  }
}

