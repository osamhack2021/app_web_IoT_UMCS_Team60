import 'package:get/get.dart';
import 'package:umcs/model/hostnames.dart';

class CohortProvider extends GetConnect {
  Future<Response> cohortStatus() => get("$restAPIHost/cohort_status", headers: {"charset" : "utf-8"});
  Future<Response> cohortStatusNow() => get("$restAPIHost/cohort_status/now", headers: {"charset" : "utf-8"});


  Future<Response> timeTableAllInfo() => get("$restAPIHost/timetable", headers: {"charset" : "utf-8"});
  Future<Response> timeTableInfo(int id) => get("$restAPIHost/timetable/$id", headers: {"charset" : "utf-8"});

  Future<Response> anomaly(data) => post("$restAPIHost/anomaly", data, headers: {"charset" : "utf-8"});
}