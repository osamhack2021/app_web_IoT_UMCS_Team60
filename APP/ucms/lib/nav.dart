import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';

class NavPage extends StatelessWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: KScreen(
          child: ListView (
            // ignore: prefer_const_literals_to_create_immutables
            children : [
              const SizedBox(height:100),
                title("navigation - dev"),
                
                PageButton(onPressed: (){
                  Navigator.pushNamed(context, "/login");
                }, label: "로그인 페이지"),
                PageButton(onPressed: (){
                  Navigator.pushNamed(context, "/register");
                }, label: "회원가입 페이지"),
                PageButton(onPressed: (){
                  Navigator.pushNamed(context, "/user/main");
                }, label: "용사 메인 페이지"),
                PageButton(onPressed: (){
                  Navigator.pushNamed(context, "/user/move");
                }, label: "이동 보고 페이지"),
                PageButton(onPressed: (){
                  Navigator.pushNamed(context, "/user/assemble");
                }, label: "소집 지시 페이지"),
            ],
          ),
        ),
      ),
    );
  }
}


