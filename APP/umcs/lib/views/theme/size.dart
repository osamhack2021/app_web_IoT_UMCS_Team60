
import 'package:flutter/material.dart';
import 'package:umcs/views/theme/color_theme.dart';
import 'package:umcs/views/theme/text_theme.dart';

SizedBox topMargin() => const SizedBox(height: 140);

SizedBox footer() {
  return SizedBox(
    child: Column(
      children: [
        const SizedBox(height: 30),
        Divider(
          color: footerTextColor(),
          thickness: 2,
        ),
        const SizedBox(height: 20),
        Text("Developed by", style: footerStyle()),
        const SizedBox(height: 5),
        Text("OSAM2021 / Team 60", style: footerStyle()),
        const SizedBox(height: 15),
        Text(
          "Liscensed under Apache 2.0",
          style: footerStyle(),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}