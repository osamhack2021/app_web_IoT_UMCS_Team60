import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              child: ListView (
                // ignore: prefer_const_literals_to_create_immutables
                children : [
                  const SizedBox(height:100),
                   const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                   const TextField(
                     decoration: InputDecoration(
                       hintText: "id",
                     ),
                   ),
                   const TextField(
                     obscureText:true,
                     decoration: InputDecoration(
                       hintText: "password",
                     ),
                   ),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : [
                    TextButton(onPressed: () {},
                      child: const Text("용사 로그인", textAlign: TextAlign.center),
                    ),
                    TextButton(onPressed: () {},
                      child: const Text("간부 로그인", textAlign: TextAlign.center),
                   ),
                    ],
                  ),
                  TextButton(onPressed: () {},
                      child: const Text("회원가입", textAlign: TextAlign.center),
                    ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
