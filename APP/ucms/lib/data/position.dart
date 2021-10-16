import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/texts.dart' as text;
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/timestring_to_datetime.dart';

class Position {
  String userTag;
  String beaconId;
  DateTime inTime;
  DateTime outTime;
  int doomId;
  String userName;
  String userRank;
  int userRoomId;
  int userDoomId;
  String name;


  Position(
      {
        required this.userTag,
        required this.beaconId,
        required this.inTime,
        required this.outTime,
        required this.doomId,
        required this.userName,
        required this.userRank,
        required this.userRoomId,
        required this.userDoomId,
        required this.name,
      });
  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트

  Position.fromJson(Map<String, dynamic> json)
      : userTag = json["user_tag"]??"",
        beaconId = json["beacon_id"]??"",
        inTime =TimestringToDateTime.encode(json["in_time"]??"1970-01-01T12:34:56.000Z"),
        outTime =TimestringToDateTime.encode(json["out_time"]??"1970-01-01T12:34:56.000Z"),
        doomId = json["doom_id"]??-1,
        userName= json["user_name"]??"",
        userRank = json["user_rank"]??"",
        userRoomId = json["user_room_id"]??-1,
        userDoomId = json["user_doom_id"]??-1,
        name = json["name"]??"";

  static void updatePrefs(Position r) {
    var store = GetStorage();

    store.write("recent_user_tag", r.userTag);
    store.write("recent_beacon_id", r.userName);
    store.write("recent_in_time", r.inTime);
    store.write("recent_out_time", r.outTime);
    store.write("recent_doom_id", r.doomId);
    store.write("recent_user_name", r.userName);
    store.write("recent_user_rank", r.userRank);
    store.write("recent_user_room_id", r.userRoomId);
    store.write("recent_user_doom_id", r.userDoomId);
    store.write("recent_place_name", r.name);
  }

  static void userInit() {
    var store = GetStorage();
    updatePrefs(Position(
        userTag : store.read("recent_user_tag"),
        beaconId :  store.read("recent_beacon_id"),
        inTime :store.read("recent_in_time"),
        outTime :store.read("recent_out_time"),
        doomId : store.read("recent_doom_id"),
        userName :store.read("recent_user_name"),
        userRank :store.read("recent_user_rank"),
        userRoomId :store.read("recent_user_room_id"),
        userDoomId :store.read("recent_user_doom_id"),
        name :store.read("recent_place_name"),
    ));
  }

  ListTile toListTile() {
    return ListTile(
              leading: const Icon(Icons.account_circle), 
              title : text.quoteLeft("$userRank $userName",),
              trailing: text.small("${inTime.month}/${inTime.day} ${inTime.hour}:${inTime.minute}"),
    );
  }
}
