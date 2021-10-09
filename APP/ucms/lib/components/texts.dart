// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/text_theme.dart';

title(content) => Text(content, style: h1(), textAlign: TextAlign.center);

class KTextFormField extends StatelessWidget {
  KTextFormField({Key? key, required this.hint, required this.controller, this.obscureText=false, required this.validator, this.type=TextInputType.text})
      : super(key: key);

  final String hint;
  TextFormField field = TextFormField();
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType type;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: GoogleFonts.nanumGothic(color : mainTextColor()),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: enabledColor()),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: selectedColor()),
                   ),  
        ),
        textAlign: TextAlign.right,
        validator: validator,
    );
  }
}
