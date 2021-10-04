import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/data/dto/move_request_dto.dart';
import 'package:ucms/data/dto/server_resp_dto.dart';
import 'package:ucms/utils/user_util/user_provider.dart';
import 'package:ucms/utils/convert_utf8.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> login(Map<String, dynamic> json) async {
    Response resp = await _userProvider.login(json);
    dynamic headers = resp.headers;
    dynamic body = resp.body;
    final prefs = GetStorage();

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);

    if (serverRespDto.code == 1) {
      User newUser = User.fromJson(serverRespDto.data);

      String token = headers["authorization"];
      prefs.write("token", token);
      prefs.write("location", newUser.location);
      return newUser;
    } else {
      return User();
    }
  }

  Future<String> register(Map<String,dynamic> json) async {
    Response resp = await _userProvider.move(json);
    dynamic body = resp.body;
    final prefs = GetStorage();

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);

    if (serverRespDto.code == 1) {
      Map<String, dynamic> data = serverRespDto.data;
      prefs.write("beacon_id", data["beacon_id"]);
    } else {}

    return serverRespDto.msg;
  }

  Future<User> move(MoveRequestDto dto) async {
    Response resp = await _userProvider.move(dto.toJson());
    dynamic headers = resp.headers;
    dynamic body = resp.body;
    final prefs = GetStorage();

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);

    //TODO: implement
    if (serverRespDto.code == 1) {
      User newUser = User.fromJson(serverRespDto.data);

      String token = headers["authorization"];
      prefs.write("token", token);
      prefs.write("location", newUser.location);
      return newUser;
    } else {
      return User();
    }
  }
}
