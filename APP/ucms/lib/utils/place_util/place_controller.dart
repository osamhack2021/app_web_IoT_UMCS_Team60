import 'package:get/get.dart';
import 'package:ucms/data/places/doom.dart';
import 'package:ucms/data/places/doomfacility.dart';
import 'package:ucms/data/places/doomroom.dart';
import 'package:ucms/data/places/outside_facility.dart';
import 'package:ucms/data/position.dart';
import 'package:ucms/data/position_list.dart';
import 'package:ucms/utils/place_util/place_repository.dart';

class PlaceController extends GetxController {
  final repository = PlaceRepository();

  Future<List<Doom>> doomAllInfo() async{
     final jsonList = await repository.doomAll();
    List<Doom> doomList =[];

    for(Map<String,dynamic> json in jsonList) {doomList.add(Doom.fromJson(json));}
    
    return doomList;
  }

  
  Future<Doom> doomInfo(int doomId) async{
    final json = await repository.doom(doomId);

    return Doom.fromJson(json);
  }

  Future<List<DoomFacility>> doomFacilAllInfo() async{
    final jsonList = await repository.doomFacilAll();
    List<DoomFacility> doomFacilList =[];

    for(Map<String,dynamic> json in jsonList) {doomFacilList.add(DoomFacility.fromJson(json));}
    
    return doomFacilList;
  }

  
  Future<DoomFacility> doomFacilInfo(int id) async{
    final json = await repository.doom(id);
    return DoomFacility.fromJson(json);
  }

  Future<List<DoomRoom>> doomRoomAllInfo() async{
    final jsonList = await repository.doomAll();
    List<DoomRoom> doomRoomList =[];

    for(Map<String,dynamic> json in jsonList) {doomRoomList.add(DoomRoom.fromJson(json));}
    
    return doomRoomList;
  }

  
  Future<DoomRoom> doomRoomInfo(int id) async{
    final json = await repository.doom(id);

    return DoomRoom.fromJson(json);
  }

  Future<List<OutsideFacility>> outsideFacilAllInfo() async{
     final jsonList = await repository.outsideFacilAll();
    
    List<OutsideFacility> outsideFacilList =[];

    for(Map<String,dynamic> json in jsonList) {
      outsideFacilList.add(OutsideFacility.fromJson(json));
    }
     return outsideFacilList;
  }

  
  Future<OutsideFacility> outsideFacilInfo(int id) async{
    final json = await repository.outsideFacil(id);

    return OutsideFacility.fromJson(json);
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

  
  Future<Position> positionInfo(int id) async{
    final json = await repository.position(id);

    return Position.fromJson(json);
  }
}
