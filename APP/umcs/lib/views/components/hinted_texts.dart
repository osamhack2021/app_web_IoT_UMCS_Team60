

import 'package:flutter/material.dart';

class TextFieldWithHint extends StatelessWidget{

  const TextFieldWithHint(this.hint, {Key? key}) : super(key: key);

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
