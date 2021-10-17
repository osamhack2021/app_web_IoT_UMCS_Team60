import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: WebBrowser(
          initialUrl: 'https://osamhack2021.github.io/app_web_IoT_UMCS_Team60/APP/ucms/build/web',
          javascriptEnabled: true,
        ),
      ),
    ),
  );
  }
}