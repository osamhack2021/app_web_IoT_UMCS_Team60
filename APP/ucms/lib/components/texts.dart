// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/text_theme.dart';

title(content) => Text(content, style: h1(), textAlign: TextAlign.center);
quote(content) => Text(content, style: body(), textAlign: TextAlign.center);

class KTextFormField extends StatelessWidget {
  KTextFormField({Key? key, required this.hint, required this.controller, this.obscureText=false, required this.validator, this.type=TextInputType.text, this.isCohort=false})
      : super(key: key);

  final String hint;
  TextFormField field = TextFormField();
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType type;
  bool obscureText;
  bool isCohort;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: GoogleFonts.nanumGothic(color : isCohort?warningColor():mainTextColor()),
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: isCohort?warningColor():enabledColor()),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: isCohort?warningColor():selectedColor()),
                   ),  
        ),
        textAlign: TextAlign.right,
        validator: validator,
    );
  }
}
