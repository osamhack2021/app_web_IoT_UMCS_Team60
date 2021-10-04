import 'package:flutter/material.dart';

class KScreen extends StatefulWidget {
  const KScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<KScreen> createState() => _KScreenState();
}

class _KScreenState extends State<KScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor : Colors.white,
      ),
      body: SafeArea(
        child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, maxHeight: 800),
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.center,
          child: widget.child,
          ),
        ),
      ),
    );
  }
}