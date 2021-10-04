import 'package:flutter/material.dart';

class MoveRequestDto {
  const MoveRequestDto({Key? key, required this.where});

  final String? where;
  
  //TODO : implement
  Map<String, dynamic> toJson() => {
        "destination": where,
      };
}
