import 'dart:convert';

dynamic convertUtf8ToObject(dynamic body) {
  String responseBody = jsonEncode(body);
  Map<String,dynamic> convertBody = jsonDecode(responseBody);
  return convertBody;
}
