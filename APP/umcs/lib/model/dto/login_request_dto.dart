import 'package:flutter/material.dart';

class LoginRequestDto {
  LoginRequestDto({ Key? key, required this.tag, required this.password });
  
  String? tag;
  String? password;

  LoginRequestDto.fromJson(Map<String, dynamic> json) {
    tag = json["tag"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "password": password,
      };
}