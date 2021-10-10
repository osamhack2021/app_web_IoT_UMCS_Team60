import 'package:flutter/material.dart';
import 'package:ucms/pages/page_login/login_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({ Key? key, required nextPage }) : super(key: key);

  Widget nextPage=LoginPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // return SplashScreen(
    //   //TODO :  spalsh loading page
    //   seconds: 14,
    //   navigateAfterSeconds: new AfterSplash(),
    //   title: quote("Untact Movement Control System"),
    //   image: Image.asset('screenshot.png'),
    //   backgroundColor: Colors.white,
    //   styleTextUnderTheLoader: new TextStyle(),
    //   photoSize: 100.0,
    //   loaderColor: Colors.red
    // );
    return Container();
  }
}