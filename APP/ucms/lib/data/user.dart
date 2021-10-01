import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String tag;
  String name;
  int roomId;
  int doomId;

  String location;
  String state;

  String token;

  

  User({this.tag="", this.name="",this.roomId=-1, 
  this.doomId=-1, this.location="", this.state ="",
  this.token=""});

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트

  User.fromJson(Map<String, dynamic> json)
      : tag = json["tag"]??"",
        name = json["name"]??"",
        roomId = json["room_id"]??-1,
        doomId = json["doom_id"]??-1,
        location = json["location"]??"",
        state = json["state"]??"",
        token = json["token"]??"";

  static void updatePrefs(User u) {
    var prefs = Get.find<SharedPreferences>();
    
    prefs.setString("tag", u.tag);
    prefs.setString("name", u.name);
    prefs.setInt("room_id",u.roomId);
    prefs.setInt("doom_id", u.doomId);
    prefs.setString("location",u.location);
    prefs.setString("state",u.state);
    prefs.setString("token",u.token);
  }
}
