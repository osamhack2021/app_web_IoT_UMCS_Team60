import 'package:get/get.dart';
import 'package:ucms/data/is_cohort.dart';
import 'package:ucms/utils/cohort_util/cohort_repository.dart';

class CohortController extends GetxController {
  final repository = CohortRepository();
  Future<List<Map<String,dynamic>>> cohortStatus() async {
    return await repository.cohortStatus();
  }
  Future<bool> cohortStatusNow() async {
    Map<String,dynamic> res = await repository.cohortStatusNow();
    
    IsCohort isCohort = IsCohort.fromJson(res);
    
    return (isCohort.isCohort==1)?true:false;
  }


  Future<Map<String,dynamic>> timeTableAllInfo() async{ 
    return {};
  }
  Future<Map<String,dynamic>> timeTableInfo(int id) async {
    return {};
  }

  Future<String> anomaly(Map<String, dynamic> data) async {
    String res = await repository.anomaly(data);
    
    return res;
  }
}
