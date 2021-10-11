class TimeZone {
  final int id;
  final int doomId;
  final int roomId;
  final int facilityId;
  final DateTime startTime;
  final DateTime endTime;

  TimeZone.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        doomId = json["doom_id"],
        roomId = json["room_id"],
        facilityId = json["facility_id"],
        startTime =DateTime.parse(json["start_time"]),
        endTime =DateTime.parse(json["end_time"]);
  
  
  Map<String, dynamic> toJson() => {
        "id" : id,
        "doom_id" : doomId,
        "room_id" : roomId,
        "facility_id" : facilityId,
        "start_time" : startTime.toString(),
        "end_time" : endTime.toString(),
      };

  // "id": 1,
  // "doom_id": 2,
  // "room_id": 4,
  // "facility_id": 4,
  // "start_time": "2021-10-04T15:10:00.000Z",
  // "end_time": "2021-10-04T15:20:00.000Z" 
}