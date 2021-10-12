import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/data/is_cohort.dart';
import 'package:ucms/utils/cohort_util/cohort_repository.dart';

class CohortController extends GetxController {
  final repository = CohortRepository();
  //TODO : implement
  Future<List<Map<String,dynamic>>> cohortStatus() async {
    return await repository.cohortStatus();
  }
  Future<bool> cohortStatusNow() async {
    Map<String,dynamic> res = await repository.cohortStatusNow();
    debugPrint(jsonEncode(res));
    IsCohort isCohort = IsCohort.fromJson(res);
    debugPrint(jsonEncode(isCohort.toJson()));
    return (isCohort.isCohort==1)?true:false;
  }


  Future<Map<String,dynamic>> timeTableAllInfo() async{ 
    return {};
  }
  Future<Map<String,dynamic>> timeTableInfo(int id) async {
    return {};
  }

  Future<Map<String,dynamic>> anomaly(Map<String, dynamic> data) async {
    return {};
  }
}
