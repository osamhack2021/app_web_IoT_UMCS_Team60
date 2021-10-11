import 'package:get/get.dart';
import 'package:ucms/data/dto/server_resp_dto.dart';
import 'package:ucms/utils/cohort_util/cohort_provider.dart';
import 'package:ucms/utils/convert_utf8.dart';

class CohortRepository {
  final CohortProvider _cohortProvider = CohortProvider();

  Future<List<Map<String,dynamic>>> cohortStatus() async {
    Response resp = await _cohortProvider.cohortStatus();
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      List<Map<String,dynamic>> data = serverRespDto.data;
      return data;
    } else {
      return [];
    }
  }
  
  Future<Map<String,dynamic>> cohortStatusNow() async {
    Response resp = await _cohortProvider.cohortStatusNow();
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      Map<String,dynamic> data = serverRespDto.data;
      return data;
    } else {
      return {};
    }
  }


  Future<List<Map<String,dynamic>>> timeTableAllInfo() async{ 
    Response resp = await _cohortProvider.timeTableAllInfo();
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      List<Map<String,dynamic>> data = serverRespDto.data;
      return data;
    } else {
      return [];
    }
  }
  Future<Map<String,dynamic>> timeTableInfo(int id) async {
    Response resp = await _cohortProvider.timeTableInfo(id);
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      Map<String,dynamic> data = serverRespDto.data;
      return data;
    } else {
      return {};
    }
  }

  Future<Map<String,dynamic>> anomaly(Map<String, dynamic> data) async {
    Response resp = await _cohortProvider.anomaly(data);
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);


    if (serverRespDto.code == 1) {
      Map<String,dynamic> data = serverRespDto.data;
      return data;
    } else {
      return {};
    }
  }
}