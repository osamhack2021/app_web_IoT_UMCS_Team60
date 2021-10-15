import 'package:ucms/data/places/place.dart';

class DoomFacility extends Place {
  DoomFacility(id, name, beaconId, this.doomId, this.floor) :super(id : id,name : name,beaconId : beaconId);

  final int doomId;
  final int floor;
  
  

  DoomFacility.fromJson(Map<String, dynamic> json) 
    : doomId = json["doomId"],
      floor = json["floor"],
      super(id:json["id"], name:json["name"], beaconId: json["beaconId"]);

  @override
  Map<String,dynamic> toJson() {
    Map<String,dynamic> result = {
      "id" : id,
      "name" : name,
      "beaconId" : beaconId,
      "doomId" : doomId,
      "floor" : floor
    };
    return result;
  }
  
}