import 'package:get/get.dart';
import 'package:ucms/data/is_cohort.dart';
import 'package:ucms/data/places/doomfacility.dart';
import 'package:ucms/data/places/place_database.dart';
import 'package:ucms/data/time_list.dart';
import 'package:ucms/data/time_zone.dart';
import 'package:ucms/utils/cohort_util/cohort_repository.dart';
import 'package:ucms/utils/convert_utf8.dart';

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


  Future<List<TimeList>> timeTableAllInfo() async{ 
    // 같은 Position 정보들을 가진 놈들을 TimeList 로 묶고,
    // 그 TimeList 를 list 로 정리한다. 
  
    //1.모든 위치정보 가져와 TimeZone 들로 만들기.
    List<dynamic> temp = await repository.timeTableAllInfo();
    List<Map<String,dynamic>> l =[];
    for(dynamic j in temp) {
      l.add(convertUtf8ToObject(j));
    }

    List<TimeZone> times =[];
    for(Map<String,dynamic> json in l) {
      times.add(TimeZone.fromJson(json));
    }
    //2. 모든 가능한 장소 불러오기
    PlaceDatabase placeDB = Get.find<PlaceDatabase>();
    List<DoomFacility> avail = placeDB.doomFacils!;

    //3. 모든 가능한 장소에 대해 PositionList 만들기

    List<TimeList> list = [];
    for(DoomFacility p in avail) {
      list.add(TimeList(list: [], place: p));
    }

    //4. position 들 각 장소에 해당하는 positionlist 의 list 에 귀속시키기
    
    for(TimeZone t in times) {
      for(int i=0;i<list.length;i++) {
        if(list[i].place.doomId==t.doomId){
          list[i].list.add(t);
          break;
        }
      }
    }
    //5. 아무도 없는 곳 떨구기?
    
     return list;
  }
  Future<Map<String,dynamic>> timeTableInfo(int id) async {
    return {};
  }

  Future<String> anomaly(Map<String, dynamic> data) async {
    String res = await repository.anomaly(data);
    
    return res;
  }
}
