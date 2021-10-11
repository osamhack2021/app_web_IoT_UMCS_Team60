import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/utils/cohort_util/cohort_repository.dart';

class CohortController extends GetxController {
  final repository = CohortRepository();
  //TODO : implement
  Future<List<Map<String,dynamic>>> cohortStatus() async {
    return await repository.cohortStatus();
  }
  Future<Map<String,dynamic>> cohortStatusNow() async {
    return {};
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
