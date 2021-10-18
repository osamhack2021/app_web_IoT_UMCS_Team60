class Anomaly {
  String tag;
  double temperature;
  String details;

  Anomaly({required this.tag, required this.temperature, required this.details});

  Anomaly.fromJson(Map<String,dynamic> json) 
  : tag = json["user_tag"],
    temperature = json["temperature"],
    details = json["details"];

  Map<String, dynamic> toJson() {
    return {
      "user_tag" : tag,
      "temperature" : temperature,
      "details" : details
    };
  }


// "user_tag": "456",
// "temperature": 38.7,
// "details": "고열, 기침"
}