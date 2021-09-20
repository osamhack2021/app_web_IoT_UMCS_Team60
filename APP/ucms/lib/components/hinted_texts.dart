// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TextFieldWithHint extends StatelessWidget{

  const TextFieldWithHint(this.hint);

  final String hint;

  @override
  Widget build(BuildContext context) {
  return TextField(
            decoration: InputDecoration(
              hintText: hint,
            ),
          );
  }
}

class KTextFormField extends StatelessWidget{

  KTextFormField({required this.hint}){
    field = TextFormField(
            decoration: InputDecoration(
              hintText: hint,
            ),
          );
  }

  final String hint;
  TextFormField field = TextFormField();

  @override
  Widget build(BuildContext context) {
  return field;
  }
}
