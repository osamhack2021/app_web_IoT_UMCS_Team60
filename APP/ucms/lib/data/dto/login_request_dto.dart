import 'package:flutter/material.dart';

class LoginRequestDto {
  const LoginRequestDto({ Key? key, required this.tag, required this.password });
  
  final String? tag;
  final String? password;

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "password": password,
      };
}