import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(AuthController());
  }
}
