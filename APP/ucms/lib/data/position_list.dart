import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/data/places/place.dart';
import 'package:ucms/data/position.dart';

class PositionList extends GetxService {

  PositionList({required this.list, required this.place});

  List<Position> list;
  Place place;

  ListView toListTiles() {
    List<ListTile> posTile =[];
    for(Position p in list) {
      posTile.add(p.toListTile());
    }
    return ListView (
      children: [...posTile],
    );
  }
}