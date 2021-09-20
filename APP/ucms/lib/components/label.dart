// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/textfields.dart';
import 'package:ucms/theme/text_theme.dart';

class LabelInput extends StatelessWidget {
  
  const LabelInput({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style:bold()),
        const Spacer(),
        Container(
          constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
          child: TextFieldWithHint(hint),
          ),
      ],
    );
  }
}

class LabelText extends StatelessWidget {
  
  const LabelText({required this.label, required this.content});

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style:const TextStyle(fontWeight: FontWeight.bold)),
      const Spacer(),
      Container(
        constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
        child: Text(content),
        ),
    ],
  );
  }
}