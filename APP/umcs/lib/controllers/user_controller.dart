import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umcs/model/position.dart';
import 'package:umcs/model/user.dart';
import 'package:umcs/model/dto/login_request_dto.dart';
import 'package:umcs/services/socket/user_socket_client.dart';
import 'package:umcs/services/beacon/beacon_manager.dart';
import 'package:umcs/domains/user/user_repository.dart';

class UserController extends GetxController {
  final repository = UserRepository();
  final RxBool isLogin = false.obs;
  final appUser = User().obs;
  var prefs = GetStorage();
  UserSocketClient socket = Get.find<UserSocketClient>();
  BeaconManager beaconManager = Get.find<BeaconManager>();

  void logout() {
    isLogin.value = false;
    prefs.write("location", "");
    prefs.write("state", "");
    prefs.write("token", "");
    User.updatePrefs(User());
  }

  Future<String> login(tag, password) async {
    final loginDto = LoginRequestDto(tag: tag, password: password);
    final newUser = await repository.login(loginDto.toJson());

    if (newUser.tag != "") {
      isLogin.value = true;
      appUser.value = newUser;
      User.updatePrefs(newUser);
      return "success";
    } else {
      return prefs.read("loginFailureMsg") ?? "에러메시지in UserController";
    }
  }

  // 제일 마지막 - 회원가입 수정하기!
  Future<String> register(Map<String, dynamic> json) async {
    //final registerDto = RegisterRequestDto.fromJson(json);
    final repository = UserRepository();
    final message = await repository.register(json);
    return message;
  }

  // 현 위치 가져와서 스토리지에 저장하는 부분-수정X recent_place_name
  Future<Map<String, dynamic>> currentPosition(String tag) async {
    final repository = UserRepository();
    final data = await repository.currentPosition(tag);

    Position.updatePrefs(Position.fromJson(data));
    return data;
  }
}