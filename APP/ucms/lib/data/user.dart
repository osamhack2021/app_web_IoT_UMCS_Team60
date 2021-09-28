class User {
  final String? tag;
  final String? name;
  final int? roomId;
  final int? doomId;
  

  User({this.tag, this.name,this.roomId, this.doomId});

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트

  User.fromJson(Map<String, dynamic> json)
      : tag = json["tag"],
        name = json["name"],
        roomId = json["room_id"],
        doomId = json["doom_id"];
}
