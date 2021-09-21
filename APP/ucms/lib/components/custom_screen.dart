

import 'package:flutter/material.dart';
import 'package:ucms/theme/size.dart';

class KScreen extends StatelessWidget {
  const KScreen({Key? key, required this.child}) : super(key: key);

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