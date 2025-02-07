import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  showErrorSnackbar(String title) {
    Get.showSnackbar(GetSnackBar(
      borderRadius: 25,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      message: title.tr,
    ));
  }
}
