import 'package:get/get.dart';
import 'package:ucms/data/places/doom.dart';
import 'package:ucms/data/places/doomfacility.dart';
import 'package:ucms/data/places/doomroom.dart';
import 'package:ucms/data/places/outside_facility.dart';
import 'package:ucms/utils/place_util/place_controller.dart';

class PlaceDatabase extends GetxService {
  List<Doom>? dooms;
  List<DoomRoom>? doomRooms;
  List<DoomFacility>? doomFacils;
  List<OutsideFacility>? outsideFacils;

  PlaceDatabase();

  Future<void> init() async {
    PlaceController p = PlaceController();
    dooms = await p.doomAllInfo();
    doomRooms = await p.doomRoomAllInfo();
    doomFacils = await p.doomFacilAllInfo();
    outsideFacils = await p.outsideFacilAllInfo();
  }

  String getDoomName(int doomId) {
    String res="";
    for(Doom d in dooms!){
      if(d.id == doomId) {res=d.name;break;}
    }
    return res;
  }

  String getOutsideFacilName(int outsideFacilId) {
    String res="";
    for(OutsideFacility o in outsideFacils!){
      if(o.id == outsideFacilId) {res=o.name;break;}
    }
    return res;
  }

  String getRoomName(int roomId) {
    String res="";
    for(DoomRoom dr in doomRooms!){
      if(dr.id == roomId) {res=dr.name; break;}
    }
    return res;
  }

}