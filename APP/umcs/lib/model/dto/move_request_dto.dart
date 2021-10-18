import 'package:flutter/material.dart';

class MoveRequestDto {
  const MoveRequestDto({Key? key, required this.outsideId, required this.description});

  final String? outsideId;
  final String? description;
  
  Map<String, dynamic> toJson() => {
        "outside_id" : outsideId,
        "description" : description
      };
}
