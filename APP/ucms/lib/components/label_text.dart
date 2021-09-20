import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

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
