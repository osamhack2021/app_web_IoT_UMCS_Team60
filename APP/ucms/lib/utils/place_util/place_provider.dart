import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';

class PlaceProvider extends GetConnect {
  //doom
  Future<Response> doomAllInfo() => get("$restAPIHost/doom", headers: {"charset" : "utf-8"});
  Future<Response> doomInfo(int doomId) => get("$restAPIHost/doom/$doomId", headers: {"charset" : "utf-8"});
  
  //doomfacility
  Future<Response> doomFacilAllInfo() => get("$restAPIHost/doomfacility", headers: {"charset" : "utf-8"});
  Future<Response> doomFacilInfo(int id) => get("$restAPIHost/doomfacility/$id", headers: {"charset" : "utf-8"});

  //doomroom
  Future<Response> doomRoomAllInfo() => get("$restAPIHost/doomroom", headers: {"charset" : "utf-8"});
  Future<Response> doomRoomInfo(int id) => get("$restAPIHost/doomroom/$id", headers: {"charset" : "utf-8"});

  //outside_facility
  Future<Response> outsideFacilAllInfo() => get("$restAPIHost/outside_facility", headers: {"charset" : "utf-8"});
  Future<Response> outsideFacilInfo(int id) => get("$restAPIHost/outside_facility/$id", headers: {"charset" : "utf-8"});

  //positions
  Future<Response> positionAllInfo() => get("$restAPIHost/current_position", headers: {"charset" : "utf-8"});
  Future<Response> positionInfo(int id) => get("$restAPIHost/current_position/$id", headers: {"charset" : "utf-8"});


}