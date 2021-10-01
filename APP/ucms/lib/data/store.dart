import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void storeInit() async {
  final store = Get.put(GetStorage("user"), tag: "user_storage");
  await GetStorage.init("user");
}
