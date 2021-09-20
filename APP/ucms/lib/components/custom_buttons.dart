// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageButton extends StatelessWidget {
  const PageButton({required this.onPressed, required this.label});

  final Function onPressed;
  final String label; 

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed(),
          child: Text(label, textAlign: TextAlign.center),
        );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({required this.onPressed, required this.label});

  final Function onPressed;
  final String label; 

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed(),
          child: Text(label, textAlign: TextAlign.center),
        );
  }
}
