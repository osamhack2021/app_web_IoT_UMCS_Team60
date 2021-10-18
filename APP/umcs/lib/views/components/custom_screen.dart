// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:umcs/views/theme/color_theme.dart';

class KScreen extends StatefulWidget {
  KScreen({Key? key, required this.child, this.bottomBar}) : super(key: key);

  final Widget child;
  dynamic bottomBar;

  @override
  State<KScreen> createState() => _KScreenState();
}

class _KScreenState extends State<KScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width, maxHeight: 900),
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: widget.child,
          ),
        ),
      ),
      bottomNavigationBar: widget.bottomBar,
      backgroundColor: backgroundColor(),
    );
  }
}

class KScreenPage extends StatefulWidget {
  KScreenPage(
      {Key? key,
      required this.child,
      this.bottomBar,
      required this.pageController})
      : super(key: key);

  final Widget child;
  dynamic bottomBar;
  PageController pageController;

  @override
  State<KScreenPage> createState() => _KScreenPageState();
}

class _KScreenPageState extends State<KScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width, maxHeight: 900),
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: PageView(
              allowImplicitScrolling: true,
              children: [widget.child],
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.bottomBar,
      backgroundColor: backgroundColor(),
    );
  }
}