import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/bindings/app_binding.dart';
import 'package:ucms/model/places/place_database.dart';
import 'package:ucms/model/user.dart';

import 'package:ucms/views/login/login_page.dart';
import 'package:ucms/services/socket/user_socket_client.dart';
import 'package:ucms/services/beacon/beacon_manager.dart';
import 'package:ucms/views/theme/color_theme.dart';

void main() async {
  await GetStorage.init();

  var client = Get.put(UserSocketClient());
  client.startSocket("");

  Get.put(BeaconManager());
  PlaceDatabase placeDB = Get.put(PlaceDatabase());
  await placeDB.init();

  User.userInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nanumGothicTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryTextTheme: GoogleFonts.nanumGothicTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: mainTextColor(),
        backgroundColor: backgroundColor(),
      ),
      initialRoute: "/login",
      routes: {
        // "/nav" : (context) => const NavPage(),
        "/login": (context) => LoginPage(),
        // "/register": (context) => RegisterPage(),
        // "/user/main": (context) => UserMain(location: "", state: ""),
        // //"/user/move": (context) => UserMove(),
        // "/user/assemble": (context) => UserAssemble(
        //     location: "막사"),
      },
    );
  }
}