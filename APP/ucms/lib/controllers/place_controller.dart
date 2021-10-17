import 'package:get/get.dart';
import 'package:ucms/model/places/doom.dart';
import 'package:ucms/model/places/doomfacility.dart';
import 'package:ucms/model/places/doomroom.dart';
import 'package:ucms/model/places/outside_facility.dart';
import 'package:ucms/model/places/place.dart';
import 'package:ucms/model/position.dart';
import 'package:ucms/model/position_list.dart';
import 'package:ucms/utils/convert_utf8.dart';
import 'package:ucms/repository/place_repository.dart';

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
    final jsonList = await repository.doomRoomAll();
    List<DoomRoom> doomRoomList =[];

    for(Map<String,dynamic> json in jsonList) {doomRoomList.add(DoomRoom.fromJson(json));}
    
    return doomRoomList;
  }

  
  Future<DoomRoom> doomRoomInfo(int id) async{
    final json = await repository.doomRoom(id);

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

  Future<List<PositionList>> positionAllInfo() async{
    // 같은 Position 정보들을 가진 놈들을 PositionList 로 묶고,
    // 그 PositionList 를 list 로 정리한다. 

    //1.모든 위치정보 가져와 Position 들로 만들기.
    List<dynamic> temp = await repository.positionAll();
    List<Map<String,dynamic>> l =[];
    for(dynamic j in temp) {
      l.add(convertUtf8ToObject(j));
    }

    List<Position> pos =[];
    for(Map<String,dynamic> json in l) {
      pos.add(Position.fromJson(json));
    }
    //2. 모든 가능한 장소 불러오기
    List<Place> avail = await allAvailablePlaces();

    //3. 모든 가능한 장소에 대해 PositionList 만들기

    List<PositionList> list = [];
    for(Place p in avail) {
      list.add(PositionList(list: [], place: p));
    }

    //4. position 들 각 장소에 해당하는 positionlist 의 list 에 귀속시키기
    
    for(Position p in pos) {
      for(int i=0;i<list.length;i++) {
        if(list[i].place.name==p.name){
          list[i].list.add(p);
          break;
        }
      }
    }
    //5. 아무도 없는 곳 떨구기?
    
     return list;
  }

  
  Future<Position> positionInfo(int id) async{
    final json = await repository.position(id);

    return Position.fromJson(json);
  }

  Future<List<Place>> allAvailablePlaces() async {
    List<Place> doom = await doomAllInfo();
    List<Place> doomRoom = await doomRoomAllInfo();
    List<Place> doomFacil = await doomFacilAllInfo();
    List<Place> outsideFacil = await outsideFacilAllInfo();

    List<Place> res =[];

    for(Place p in doom) {res.add(p);}
    for(Place p in doomRoom) {res.add(p);}
    for(Place p in doomFacil) {res.add(p);}
    for(Place p in outsideFacil) {res.add(p);}

    return res;
  }
}
