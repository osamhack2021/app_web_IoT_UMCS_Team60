class DoomFacility {
  DoomFacility(this.id, this.name, this.beaconId, this.doomId, this.floor);
  
  final int id;
  final String name;
  final String beaconId;
  final int doomId;
  final int floor;
  
  

  DoomFacility.fromJson(Map<String, dynamic> json) 
    : id = json["id"],
      name = json["name"],
      beaconId = json["beaconId"],
      doomId = json["doomId"],
      floor = json["floor"];

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