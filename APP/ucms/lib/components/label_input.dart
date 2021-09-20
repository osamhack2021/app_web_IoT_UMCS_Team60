import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabelInput extends StatelessWidget {
  const LabelInput({
    Key? key,
    required this.label,
    required this.hint,
  }) : super(key: key);

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style:const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Container(
          constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}
