import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:ucms/data/position.dart';

class PositionList extends GetxService {

  PositionList();

  List<Position> list=[];

  PositionList.fromList(List<Position> l) 
    : list =l;
  
}