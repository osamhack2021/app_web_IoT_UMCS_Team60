
class ServerMultiRespDto {
  final int code;
  final String msg;
  final List<dynamic> data;

  ServerMultiRespDto({required this.code, required this.msg, required this.data});

  ServerMultiRespDto.fromJson(Map<String,dynamic> json, List<Map<String,dynamic>> dat)
      : code = json["code"],
        msg = json["msg"],
        data = dat;
  
  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data" : data,
      };
}