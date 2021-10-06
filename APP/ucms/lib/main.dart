import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/data/user.dart';

import 'package:ucms/pages/page_login/login_page.dart';
import 'package:ucms/pages/page_login/register_page.dart';
import 'package:ucms/nav.dart';
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/pages/page_user/user_move.dart';
import 'package:ucms/socket/socket.dart';
import 'package:ucms/utils/beacon_manager.dart';

void main() async {
  await GetStorage.init();

   //var client = Get.put(UserSocketClient());
  //client.startSocket();
  
  User.userInit();

  //Get.put(BeaconManager());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            primary: Colors.deepPurple, //글자 색.//정체성
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ), //RoundedRectangleBorer
            minimumSize: const Size(400, 60),
          ),
          ), //styleFrom
      ),
      initialRoute: "/nav",
      routes: {
        "/nav" : (context) => const NavPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/user/main": (context) => UserMain(location: "".obs, state: "".obs),
        "/user/move": (context) => const UserMove(),
        "/user/assemble": (context) => UserAssemble(
            location: "막사", timestamp: DateTime.parse("2012-02-27 13:27:00")),
      },
    );
  }
}
