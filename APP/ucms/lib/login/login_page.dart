import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/form/form_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: KScreen(
          child: ListView (
            // ignore: prefer_const_literals_to_create_immutables
            children : [
              const SizedBox(height:100),
                title("login"),
                FormLogin(),
            ],
          ),
        ),
      ),
    );
  }
}


