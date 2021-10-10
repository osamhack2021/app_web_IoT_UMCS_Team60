import 'dart:convert';

dynamic convertUtf8ToObject(dynamic body) {
  String responseBody = jsonEncode(body);
  dynamic convertBody = jsonDecode(responseBody);
  return convertBody;
}
