import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ucms/model/is_cohort.dart';
import 'package:ucms/model/places/doomfacility.dart';
import 'package:ucms/model/places/place_database.dart';
import 'package:ucms/model/time_list.dart';
import 'package:ucms/model/time_zone.dart';
import 'package:ucms/domains/cohort/cohort_repository.dart';
import 'package:ucms/utils/convert_utf8.dart';

class CohortController extends GetxController {
  final repository = CohortRepository();
  RxBool isCohort = false.obs;

  RxList<TimeList> times = RxList();

  Future<void> init() async {}

  @override
  onInit() async {
    super.onInit();

    await cohortStatusNow();
    debugPrint("========== CohortController cohortStatusNow Done ==========");
    timeTableAllInfo().then((_) {
    debugPrint("========== CohortController timeTableAllInfo Done ==========");
    });
  }

  Future<List<Map<String, dynamic>>> cohortStatus() async {
    return await repository.cohortStatus();
  }

  Future<void> cohortStatusNow() async {
    Map<String, dynamic> res = await repository.cohortStatusNow();

    IsCohort isCohortJson = IsCohort.fromJson(res);
    isCohort.value = (isCohortJson.isCohort == 1) ? true : false;
  }

  Future<void> timeTableAllInfo() async {
    // 같은 Position 정보들을 가진 놈들을 TimeList 로 묶고,
    // 그 TimeList 를 list 로 정리한다.

    //1.모든 위치정보 가져와 TimeZone 들로 만들기.
    List<dynamic> temp = await repository.timeTableAllInfo();
    List<Map<String, dynamic>> l = [];
    for (dynamic j in temp) {
      l.add(convertUtf8ToObject(j));
    }

    List<TimeZone> innerTimes = [];
    for (Map<String, dynamic> json in l) {
      innerTimes.add(TimeZone.fromJson(json));
    }
    //2. 모든 가능한 장소 불러오기
    PlaceDatabase placeDB = Get.find<PlaceDatabase>();
    List<DoomFacility> avail = placeDB.doomFacils!;

    //3. 모든 가능한 장소에 대해 PositionList 만들기

    List<TimeList> list = [];
    for (DoomFacility p in avail) {
      list.add(TimeList(list: [], place: p));
    }

    //4. position 들 각 장소에 해당하는 positionlist 의 list 에 귀속시키기

    for (TimeZone t in innerTimes) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].place.doomId == t.doomId) {
          list[i].list.add(t);
          break;
        }
      }
    }
    //5. 아무도 없는 곳 떨구기?

    times.value = list;
  }

  Future<Map<String, dynamic>> timeTableInfo(int id) async {
    return {};
  }

  Future<String> anomaly(Map<String, dynamic> data) async {
    String res = await repository.anomaly(data);

    return res;
  }
}