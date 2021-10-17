// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/views/theme/color_theme.dart';

class PageButton extends StatelessWidget {
  const PageButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label, textAlign: TextAlign.center),
        style: TextButton.styleFrom(
          backgroundColor: buttonbackColor(),
          primary: buttonTextColor(), //글자 색.//정체성
          textStyle: GoogleFonts.nanumGothic(),
        ),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label, textAlign: TextAlign.center),
        style: TextButton.styleFrom(
          backgroundColor: buttonbackColor(),
          primary: buttonTextColor(),
          textStyle: GoogleFonts.nanumGothic(),
        ),
      ),
    );
  }
}

class WarnButton extends StatelessWidget {
  const WarnButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label, textAlign: TextAlign.center),
        style: TextButton.styleFrom(
          backgroundColor: warningColor(),
          primary: buttonTextColor(),
          textStyle: GoogleFonts.nanumGothic(),
        ),
      ),
    );
  }
}
