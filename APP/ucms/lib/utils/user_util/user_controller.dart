import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/data/dto/login_request_dto.dart';
import 'package:ucms/data/dto/move_request_dto.dart';
import 'package:ucms/utils/user_util/user_repository.dart';

class UserController extends GetxController {
  final RxBool isLogin = false.obs;
  final appUser = User().obs;
  GetStorage prefs = Get.find<GetStorage>();

  void logout() {
    isLogin.value = false;
    prefs.write("token", "");
  }

  Future<int> login(tag, password) async {
    final loginDto = LoginRequestDto(tag: tag, password: password);
    final repository = UserRepository();
    final newUser = await repository.login(loginDto);

    if (newUser.tag != "") {
      isLogin.value = true;
      appUser.value = newUser;
      User.updatePrefs(newUser);
      return 1;
    } else {
      return -1;
    }
  }

  Future<int> move({required String where}) async {
    final moveDto = MoveRequestDto(where: where);
    final repository = UserRepository();
    final p = await repository.move(moveDto);

    //TODO: implement
    if (p.tag != "") {
      isLogin.value = true;
      appUser.value = p;
      return 1;
    } else {
      return -1;
    }
  }
}
