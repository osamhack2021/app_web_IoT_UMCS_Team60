import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';

class UserProvider extends GetConnect {
  // Promise (데이터 약속)
  Future<Response> login(Map data) => post("$loginHost/login", data);
}