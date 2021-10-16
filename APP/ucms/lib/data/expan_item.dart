import 'package:flutter/material.dart';

class ExpanItem {
  bool expanded;
  String header;
  ListView body;

  ExpanItem({required this.expanded, required this.header, required this.body});
}