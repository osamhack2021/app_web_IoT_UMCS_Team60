import 'package:flutter/material.dart';
import 'package:ucms/login/login_page.dart';
import 'package:ucms/login/register_page.dart';
import 'package:ucms/nav.dart';
import 'package:ucms/user/user_assemble.dart';
import 'package:ucms/user/user_main.dart';
import 'package:ucms/user/user_move.dart';

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
      initialRoute: "/nav",
      routes: {
        "/nav" : (context) => const NavPage(),
        "/login": (context) => const LoginPage(),
        "/register" : (context) => const RegisterPage(),
        "/user/main" : (context) => UserMain(location : "막사", state : "막사대기중"),
        "/user/move": (context) => const UserMove(),
        "/user/assemble" : (context) => UserAssemble(location: "막사", timestamp: DateTime.parse("2012-02-27 13:27:00")), 
      },
    );
  }
}
