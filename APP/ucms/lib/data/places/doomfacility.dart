import 'package:ucms/data/places/place.dart';

class DoomFacility extends Place {
  DoomFacility(id, name, beaconId, this.doomId, this.floor) :super(id : id,name : name,beaconId : beaconId);

  final int doomId;
  final int floor;
  
  

  DoomFacility.fromJson(Map<String, dynamic> json) 
    : doomId = json["doom_id"],
      floor = json["floor"],
      super(id:json["id"], name:json["name"], beaconId: json["beacon_id"]);

  @override
  Map<String,dynamic> toJson() {
    Map<String,dynamic> result = {
      "id" : id,
      "name" : name,
      "beacon_id" : beaconId,
      "doom_id" : doomId,
      "floor" : floor
    };
    return result;
  }
  
}