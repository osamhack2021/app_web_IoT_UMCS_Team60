
class IsCohort {
  
  int id;
  int isCohort;
  String time;


  IsCohort(
      {
        required this.id,
        required this.isCohort,
        required this.time,
      });
  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트

  IsCohort.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        isCohort = json["isCohort"],
        time =json["time"];
  
  Map<String,dynamic> toJson() {
    return {
      "id" : id,
      "isCohort" : isCohort,
      "time" : time
    };
  }

}
