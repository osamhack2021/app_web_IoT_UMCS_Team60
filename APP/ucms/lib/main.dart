import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ucms/background/background_manager.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/notification/noti_test_page.dart';

import 'package:ucms/pages/page_login/login_page.dart';
import 'package:ucms/pages/page_login/register_page.dart';
import 'package:ucms/nav.dart';
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/pages/page_user/user_move.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/beacon/beacon_manager.dart';
import 'package:ucms/theme/color_theme.dart';

import 'notification/noti_manager.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  
  var client = Get.put(UserSocketClient());
  client.startSocket();
  
  Get.put(BeaconManager());

  var backMan = Get.put(BackgroundManager());
  backMan.man.initialize(
    backMan.callbackDispatcher,
      isInDebugMode: true 
  );

  var notiMan = Get.put(NotiManager());
  notiMan.initState();
   
  User.userInit();

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.nanumGothicTextTheme(
             Theme.of(context).textTheme,
          ),
        primaryTextTheme: GoogleFonts.nanumGothicTextTheme(
             Theme.of(context).textTheme,
          ),
        primaryColor : mainTextColor(),
        backgroundColor: backgroundColor(),
      ),
      initialRoute: "/nav",
      routes: {
        "/noti_test" : (context) => const NotiTestPage(),
        "/nav" : (context) => const NavPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/user/main": (context) => UserMain(location: "", state: ""),
        "/user/move": (context) => const UserMove(),
        "/user/assemble": (context) => UserAssemble(
            location: "막사"),
      },
    );
  }

  
}
