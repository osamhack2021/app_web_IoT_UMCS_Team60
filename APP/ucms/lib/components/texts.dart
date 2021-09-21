

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/theme/text_theme.dart';

title(content) => Text(content, style: h1(),textAlign: TextAlign.center);

class KTextFormField extends StatelessWidget{

  KTextFormField({Key? key, required this.hint}) : super(key: key);

  final String hint;
  TextFormField field = TextFormField();

  @override
  Widget build(BuildContext context) {
  return Container(
    constraints: const BoxConstraints(maxHeight: 30,maxWidth: 100),
    child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
            ),
          ),
    );
  }
}

class KTextFormArea extends StatefulWidget{

  const KTextFormArea({Key? key, required this.hint}) : super(key: key);

  final String hint;

  @override
  State<KTextFormArea> createState() => _KTextFormAreaState();
}

class _KTextFormAreaState extends State<KTextFormArea> {
  TextFormField field = TextFormField();

  @override
  Widget build(BuildContext context) {
  return TextFormField(
            decoration: InputDecoration(
              hintText: widget.hint,
            ),
            onChanged: (text) {
              setState(() {
                if(text.isNotEmpty) ChoiceButton.selected="기타"; 
                print("ChoiceButton.selected="+ChoiceButton.selected);
               ChoiceButtonGroup.check!();
              });
            }
          );
  }
}