import 'package:flutter/material.dart';

class RegisterRequestDto {
  const RegisterRequestDto({ 
    Key? key, required this.tag, 
    required this.password, 
    required this.name, 
    required this.rank, 
    required this.roomId, 
    required this.doomId, 
    required this.department,});
  
  final String? tag;
  final String? password;
  final String? name;
  final String? rank;
  final int? roomId;
  final int? doomId;
  final String? department;
  

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