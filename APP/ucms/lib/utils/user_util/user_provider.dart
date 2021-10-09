import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';

class UserProvider extends GetConnect {
  // Promise (데이터 약속)
  Future<Response> login(Map data) => post("$restAPIHost/user/login", data);

  Future<Response> register(Map data)=> post("$restAPIHost/user/register", data);
}
