import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';

class PlaceProvider extends GetConnect {
  //doom
  Future<Response> doomAllInfo() => get("$restAPIHost/doom");
  Future<Response> doomInfo(String doomId) => get("$restAPIHost/doom/:$doomId");
  
  //doomfacility

  //TODO: doomroom

  //TODO: outside_facility

}