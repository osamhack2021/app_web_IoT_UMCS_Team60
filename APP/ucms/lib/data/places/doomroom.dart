class DoomRoom {
  DoomRoom(this.id, this.name, this.beaconId, this.doomId, this.floor);
  
  final int id;
  final String beaconId;
  final int doomId;
  final int floor;
  final String name;
  

  DoomRoom.fromJson(Map<String, dynamic> json) 
    : id = json["id"],
      beaconId = json["beaconId"],
      doomId = json["doomId"],
      floor = json["floor"],
      name = json["name"];

  Map<String,dynamic> toJson() {
    Map<String,dynamic> result = {
      "id" : id,
      "beaconId" : beaconId,
      "doomId" : doomId,
      "floor" : floor,
      "name" : name
    };
    return result;
  }
  
}