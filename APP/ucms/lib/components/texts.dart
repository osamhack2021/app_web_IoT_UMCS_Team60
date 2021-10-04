// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ucms/theme/text_theme.dart';

title(content) => Text(content, style: h1(), textAlign: TextAlign.center);

class KTextFormField extends StatelessWidget {
  KTextFormField({Key? key, required this.hint, required this.controller, required this.validator, this.type=TextInputType.text})
      : super(key: key);

  final String hint;
  TextFormField field = TextFormField();
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 30, maxWidth: 100),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
        ),
        validator: validator,
      ),
    );
  }
}
