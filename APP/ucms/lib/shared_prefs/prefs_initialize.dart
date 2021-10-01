import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void prefsInitialize() async {
  SharedPreferences prefs = Get.put(await SharedPreferences.getInstance());
  prefs.setBool("isLogin",prefs.getBool("isLogin")??false);

  //logined user info
  prefs.setString("token", prefs.getString("token")??"");
  prefs.setString("tag", prefs.getString("tag")??"");
  prefs.setString("name", prefs.getString("name")??"");
  prefs.setString("location", prefs.getString("location")??"");
  prefs.setString("state", prefs.getString("state")??"");
  prefs.setInt("roomId", prefs.getInt("roomId")??-1);
  prefs.setInt("doomId", prefs.getInt("doomId")??-1);

}