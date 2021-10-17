import 'package:ucms/model/places/place.dart';

class DoomRoom  extends Place{
  DoomRoom({required id, required name, required beaconId, required this.doomId, required this.floor})
    : super(id: id, name: name, beaconId: beaconId);
  

  final int doomId;
  final int floor;
  

  DoomRoom.fromJson(Map<String, dynamic> json) 
    : doomId = json["doom_id"],
      floor = json["floor"],
      super(id: json["id"], name: json["name"], beaconId: json["beacon_id"]);

  @override
  Map<String,dynamic> toJson() {
    Map<String,dynamic> result = {
      "id" : id,
      "beacon_id" : beaconId,
      "doom_id" : doomId,
      "floor" : floor,
      "name" : name
    };
    return result;
  }
  
}