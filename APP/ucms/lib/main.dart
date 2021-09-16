import 'package:flutter/material.dart';
import 'package:ucms/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            primary: Colors.white, //글자 색.//정체성
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ), //RoundedRectangleBorer
            minimumSize: const Size(400, 60),
          ), //styleFrom
        ),
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
      },
    );
  }
}