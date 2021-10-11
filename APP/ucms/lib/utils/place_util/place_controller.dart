//TODO: implement

import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';
import 'package:ucms/data/position.dart';
import 'package:ucms/data/position_list.dart';
import 'package:ucms/utils/place_util/place_repository.dart';

class PlaceController extends GetxController {
  final repository = PlaceRepository();

  Future<List<dynamic>> doomAllInfo() async{
     final doomList = await repository.doomAll();

     return doomList;
  }

  
  Future<dynamic> doomInfo(int doomId) async{
    final doom = await repository.doom(doomId);

    return doom;
  }

  Future<List<dynamic>> doomFacilAllInfo() async{
     final doomFacilList = await repository.doomFacilAll();

     return doomFacilList;
  }

  
  Future<dynamic> doomFacilInfo(int id) async{
    final doomFacil = await repository.doom(id);

    return doomFacil;
  }
  Future<List<dynamic>> doomRoomAllInfo() async{
     final doomRoomList = await repository.doomAll();

     return doomRoomList;
  }

  
  Future<dynamic> doomRoomInfo(int id) async{
    final doomRoom = await repository.doom(id);

    return doomRoom;
  }

  Future<List<dynamic>> outsideFacilAllInfo() async{
     final outsideFacilList = await repository.outsideFacilAll();

     return outsideFacilList;
  }

  
  Future<dynamic> outsideFacilInfo(int id) async{
    final outsideFacil = await repository.outsideFacil(id);

    

    return outsideFacil;
  }

  Future<PositionList> positionAllInfo() async{
    List<Map<String,dynamic>> l = await repository.positionAll();
    List<Position> positionList =[];

    for(Map<String,dynamic> json in l) {
      positionList.add(Position.fromJson(json));
    }
    
    PositionList list = PositionList.fromList(positionList);

     return list;
  }

  
  Future<dynamic> positionInfo(int id) async{
    final position = await repository.position(id);

    return position;
  }
}
