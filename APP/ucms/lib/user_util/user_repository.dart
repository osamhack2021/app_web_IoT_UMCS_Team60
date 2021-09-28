import 'package:get/get.dart';
import 'package:ucms/data/jwt.dart';
import 'package:ucms/data/user.dart';
import 'package:ucms/dto/login_request_dto.dart';
import 'package:ucms/dto/server_resp_dto.dart';
import 'package:ucms/user_util/user_provider.dart';
import 'package:ucms/utils/convert_utf8.dart';

class UserRepository{
  final UserProvider _userProvider = UserProvider();

  Future<User> login(LoginRequestDto dto) async {
    Response resp = await _userProvider.login(dto.toJson());
    dynamic headers = resp.headers;
    dynamic body = resp.body;

    dynamic convertBody = convertUtf8ToObject(body);
    ServerRespDto serverRespDto = ServerRespDto.fromJson(convertBody);

    if(serverRespDto.code ==1) {
      User principal = User.fromJson(serverRespDto.data);

      String token = headers["authorization"];
      jwtToken = token;

      return principal;
    } else {
      return User();
    }

  }
}