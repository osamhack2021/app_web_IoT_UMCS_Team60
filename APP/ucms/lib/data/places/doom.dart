class Doom {
  Doom(this.id, this.name, this.beaconId);
  
  final int id;
  final String name;
  final String beaconId;

  Doom.fromJson(Map<String, dynamic> json) 
    : id = json["id"],
      name = json["name"],
      beaconId = json["beaconId"];

  Map<String,dynamic> toJson() {
    Map<String,dynamic> result = {
      "id" : id,
      "name" : name,
      "beaconId" : beaconId
    };
    return result;
  }
  
}