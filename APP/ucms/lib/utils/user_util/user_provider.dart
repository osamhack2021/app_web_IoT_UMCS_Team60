import 'package:get/get.dart';
import 'package:ucms/data/hostnames.dart';
import 'package:http/http.dart' as http;

class UserProvider extends GetConnect {
  // Promise (데이터 약속)
  Future<http.Response> login(Map data) => http.post(Uri.parse("$restAPIHost/user/login"),body : data, headers: {"charset" : "utf-8"});

  Future<http.Response> register(Map data)=> http.post(Uri.parse("$restAPIHost/user/register"), body : data);

  Future<http.Response> currentPosition(String tag) => http.get(Uri.parse("$restAPIHost/current_position/$tag"));

  Future<http.Response> currentPositionAll() => http.get(Uri.parse("$restAPIHost/current_position"));
}
