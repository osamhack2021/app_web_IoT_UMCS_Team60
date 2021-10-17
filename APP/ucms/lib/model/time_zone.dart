import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/model/places/place_database.dart';
import 'package:ucms/utils/timestring_to_datetime.dart';
import 'package:ucms/views/components/texts.dart' as text;

class TimeZone {
  final int id;
  final int doomId;
  final int roomId;
  final int facilityId;
  final DateTime startTime;
  final DateTime endTime;
  PlaceDatabase placeDB = Get.find<PlaceDatabase>();

  TimeZone.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        doomId = json["doom_id"],
        roomId = json["room_id"],
        facilityId = json["facility_id"],
        startTime =TimestringToDateTime.encode(json["start_time"]??"1970-01-01T12:34:56.000Z"),
        endTime =TimestringToDateTime.encode(json["end_time"]??"1970-01-01T12:34:56.000Z");
  
  
  Map<String, dynamic> toJson() => {
        "id" : id,
        "doom_id" : doomId,
        "room_id" : roomId,
        "facility_id" : facilityId,
        "start_time" : startTime.toString(),
        "end_time" : endTime.toString(),
      };
  ListTile toListTile() { 
    String doomName = placeDB.getDoomName(doomId);
    String roomName = placeDB.getRoomName(roomId);
    return ListTile(
              title : text.quoteLeft("$doomName $roomName",),
              trailing: text.quote("${startTime.hour}:${startTime.minute} ~ ${endTime.hour}:${endTime.minute} "),
    );
  }
  // "id": 1,
  // "doom_id": 2,
  // "room_id": 4,
  // "facility_id": 4,
  // "start_time": "2021-10-04T15:10:00.000Z",
  // "end_time": "2021-10-04T15:20:00.000Z" 
}