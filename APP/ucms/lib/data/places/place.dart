class Place {
  Place({required this.id, required this.name, required this.beaconId});
  
  final int id;
  final String name;
  final String beaconId;

  Place.fromJson(Map<String, dynamic> json) 
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