import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umcs/model/places/place.dart';
import 'package:umcs/model/position.dart';

class PositionList extends GetxService {

  PositionList({required this.list, required this.place});

  List<Position> list;
  Place place;

  Column toListTiles() {
    List<ListTile> posTile =[];
    for(Position p in list) {
      posTile.add(p.toListTile());
    }
    return Column (
      children: [...posTile],
    );
  }
}