import 'package:get/get.dart';


@Deprecated("no longer uses this for shared preferences.")
class Store extends GetXState {
  String? tag;
  String? name;
  int? roomId;
  int? doomId;
  String? location;
  String? state;
  String? token;
  bool? isLogin;
}