import 'package:flutter/material.dart';

class ExpanItem {
  bool expanded;
  String header;
  Column body;

  ExpanItem({required this.expanded, required this.header, required this.body});
}