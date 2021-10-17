import 'package:ucms/model/places/place.dart';

class Doom extends Place {
  Doom(id, name, beaconId) : super(id : id,name : name,beaconId : beaconId);
  

  Doom.fromJson(Map<String, dynamic> json) 
    : super.fromJson(json);

  // @override
  // Map<String,dynamic> toJson() {
  //   return super.toJson();
  // }
  
}