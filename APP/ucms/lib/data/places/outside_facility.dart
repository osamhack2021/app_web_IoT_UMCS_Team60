import 'package:ucms/data/places/place.dart';

class OutsideFacility extends Place{
   OutsideFacility({required id, required name, required beaconId}) 
    :super(id: id,name: name, beaconId: beaconId);
  

  OutsideFacility.fromJson(Map<String, dynamic> json) 
    : super(id: json["id"], name: json["name"], beaconId: json["beaconId"]);

  // @override
  // Map<String,dynamic> toJson() {
  //   return super.toJson();
  // }
  
}