import 'package:flutter/material.dart';

class RegisterRequestDto {
  RegisterRequestDto({ 
    Key? key, required this.tag, 
    required this.password, 
    required this.name, 
    required this.rank, 
    required this.roomId, 
    required this.doomId, 
    required this.department,});

  RegisterRequestDto.fromJson(Map<String, dynamic> json) {
    tag = json["tag"];
    password = json["password"];
    name = json["name"];
    rank = json["rank"];
    roomId = json["roomId"];
    doomId = json["doomId"];
    department = json["department"];
  }
  
  String? tag;
  String? password;
  String? name;
  String? rank;
  int? roomId;
  int? doomId;
  String? department;
  

  Map<String, dynamic> toJson() => {
        "tag" : tag, 
	      "password" : password,
	      "name" : name,
	      "rank" : rank,
	      "room_id" : roomId,
	      "doom_id" : doomId,
	      "department" : department,
      };
}