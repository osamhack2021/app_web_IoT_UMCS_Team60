import 'package:get/instance_manager.dart';
import 'package:umcs/controllers/cohort_controller.dart';
import 'package:umcs/controllers/place_controller.dart';
import 'package:umcs/controllers/user_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CohortController());
    Get.put(UserController());
    Get.put(PlaceController());
  }
}