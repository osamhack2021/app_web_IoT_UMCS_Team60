
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ucms/theme/size.dart';

class KScreen extends StatelessWidget {
  const KScreen({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
      constraints: constraintScreen(),
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.center,
        child: child,
        ),
      ),
    );
  }
}