import 'package:get_storage/get_storage.dart';

class User {
  String tag;
  String name;
  int roomId;
  int doomId;

  String location; //beaconId 랑 매칭
  String state;

  String token;

  User(
      {this.tag = "",
      this.name = "",
      this.roomId = -1,
      this.doomId = -1,
      this.location = "",
      this.state = "",
      this.token = ""});

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트

  User.fromJson(Map<String, dynamic> json)
      : tag = json["tag"] ?? "",
        name = json["name"] ?? "",
        roomId = json["room_id"] ?? -1,
        doomId = json["doom_id"] ?? -1,
        location = json["location"] ?? "",
        state = json["state"] ?? "",
        token = json["token"] ?? "";

  static void updatePrefs(User u) {
    var store = GetStorage();

    store.write("tag", u.tag);
    store.write("name", u.name);
    store.write("room_id", u.roomId);
    store.write("doom_id", u.doomId);
    store.write("location", u.location);
    store.write("state", u.state);
    store.write("token", u.token);
  }

  static void userInit() {
    var store = GetStorage();
    updatePrefs(User(
      tag: store.read("store") ?? "",
      name: store.read("name") ?? "",
      roomId: store.read("room_id") ?? -1,
      doomId: store.read("doom_id") ?? -1,
      location: store.read("location") ?? "",
      state: store.read("state") ?? "",
      token: store.read("token") ?? "",
    ));
  }
}
