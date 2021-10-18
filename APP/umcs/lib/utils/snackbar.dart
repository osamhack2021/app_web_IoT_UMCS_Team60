import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umcs/views/theme/color_theme.dart';

class Snack {

  static Color backColor = snackbarBackColor();
  static Color warnBackColor = warningColor();


  static void top(title, message) {
    Get.snackbar(title, message,
                      backgroundColor: backColor,
                      margin : const EdgeInsets.all(20),
                      snackPosition: SnackPosition.TOP,
                    );
  }

  static void bottom(title, message){
    Get.snackbar(title, message,
                      backgroundColor: backColor,
                      margin : const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                    );
  }

  static void warnTop(title, message){
    Get.snackbar(title, message,
                      backgroundColor: warnBackColor,
                      margin : const EdgeInsets.all(20),
                      snackPosition: SnackPosition.TOP,
                    );
  }

}