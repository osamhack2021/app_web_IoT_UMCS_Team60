import 'package:flutter/material.dart';

class MoveRequestDto {
  const MoveRequestDto({Key? key, required this.destination});

  final String? destination;
  
  Map<String, dynamic> toJson() => {
        "destination": destination,
      };
}
