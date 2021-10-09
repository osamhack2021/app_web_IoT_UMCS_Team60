import 'package:flutter/material.dart';

class MoveRequestDto {
  const MoveRequestDto({Key? key, required this.destination});

  final String? destination;
  
  //TODO : implement
  Map<String, dynamic> toJson() => {
        "destination": destination,
      };
}
