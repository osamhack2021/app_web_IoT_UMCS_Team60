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