import 'package:get/get.dart';
import 'package:ucms/data/position.dart';

class PositionList extends GetxService {

  PositionList() : list=[];

  List<Position> list;

  PositionList.fromList(List<Position> l) :list=[] {
    for(Position p in l) {
      list.add(p);
    }} 
  
}