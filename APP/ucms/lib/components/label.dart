import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/theme/text_theme.dart';

class LabelFormInput extends StatelessWidget {
  
  const LabelFormInput({Key? key, required this.label, required this.hint}) : super(key: key);

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
          child: KTextFormField(hint : hint),
          ),
      ],
    );
  }
}

class LabelText extends StatelessWidget {
  
  const LabelText({Key? key, required this.label, required this.content}) : super(key: key);

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