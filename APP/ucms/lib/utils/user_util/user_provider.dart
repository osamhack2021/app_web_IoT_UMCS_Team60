import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';

class UserProvider extends GetConnect {
  // Promise (데이터 약속)
  Future<Response> login(Map data) => post("$restAPIHost/user/login", data, headers: {"charset" : "utf-8"});

  Future<Response> register(Map data)=> post("$restAPIHost/user/register", data, headers: {"charset" : "utf-8"});

  Future<Response> currentPosition(String tag) => get("$restAPIHost/current_position/$tag", headers: {"charset" : "utf-8"});

  Future<Response> currentPositionAll() => get("$restAPIHost/current_position", headers: {"charset" : "utf-8"});
}
