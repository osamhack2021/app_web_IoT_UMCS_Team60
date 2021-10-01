import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/dto/login_request_dto.dart';
import 'package:ucms/user_util/user_repository.dart';

class UserController extends GetxController{
  final RxBool isLogin = false.obs;
  final appUser = User().obs;
  var prefs = Get.find<SharedPreferences>();

  void logout() {
    isLogin.value = false;
    prefs.setString("token", "");
  }

  Future<int> login(tag, password) async {
      final loginDto = LoginRequestDto( tag : tag, password : password);
      final repository = UserRepository();
      final newUser =  await repository.login(loginDto);
      
      if (newUser.tag != "") {
        isLogin.value = true;
        appUser.value = newUser;
        User.updatePrefs(newUser);
        return 1;
      } else {return -1;}
  }
}