import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/model/places/doomfacility.dart';
import 'package:ucms/model/time_zone.dart';

class TimeList extends GetxService {

  TimeList({required this.list, required this.place});

  List<TimeZone> list;
  DoomFacility place;

  Column toListTiles() {
    List<ListTile> timeTile =[];
    for(TimeZone t in list) {
      timeTile.add(t.toListTile());
    }
    return Column (
      children: [...timeTile],
    );
  }
}