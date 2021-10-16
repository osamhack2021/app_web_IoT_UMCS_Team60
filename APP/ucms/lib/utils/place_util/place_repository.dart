
import 'package:get/get.dart';
import 'package:ucms/data/dto/server_multi_resp_dto.dart';
import 'package:ucms/data/dto/server_resp_dto.dart';
import 'package:ucms/utils/convert_utf8.dart';
import 'package:ucms/utils/place_util/place_provider.dart';

class PlaceRepository {
  final PlaceProvider _placeProvider = PlaceProvider();
  
  Future<List<Map<String,dynamic>>> doomAll() async {
     Response resp = await _placeProvider.doomAllInfo();
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
  Future<Map<String,dynamic>> doom(int doomId) async {
     Response resp = await _placeProvider.doomInfo(doomId);
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

  Future<List<Map<String,dynamic>>> doomRoomAll() async {
     Response resp = await _placeProvider.doomRoomAllInfo();
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
  Future<Map<String,dynamic>> doomRoom(int doomRoomId) async {
     Response resp = await _placeProvider.doomRoomInfo(doomRoomId);
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

  Future<List<Map<String,dynamic>>> doomFacilAll() async {
     Response resp = await _placeProvider.doomFacilAllInfo();
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
  Future<Map<String,dynamic>> doomFacil(int doomFacilId) async {
     Response resp = await _placeProvider.doomFacilInfo(doomFacilId);
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

  Future<List<Map<String,dynamic>>> outsideFacilAll() async {
     Response resp = await _placeProvider.outsideFacilAllInfo();
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
  Future<Map<String,dynamic>> outsideFacil(int outsideFacilId) async {
     Response resp = await _placeProvider.outsideFacilInfo(outsideFacilId);
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

  Future<List<Map<String,dynamic>>> positionAll() async {
     Response resp = await _placeProvider.positionAllInfo();
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerMultiRespDto serverRespDto = ServerMultiRespDto.fromJson(convertBody, convertBody["data"]);


    if (serverRespDto.code == 1) {
      List<Map<String,dynamic>> data = serverRespDto.data;
      return data;
    } else {
      return [];
    }

  }
  Future<Map<String,dynamic>> position(int id) async {
     Response resp = await _placeProvider.positionInfo(id);
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