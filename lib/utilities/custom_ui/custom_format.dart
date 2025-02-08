import 'package:erbil/controller/main_controller.dart';
import 'package:get/get.dart';

class CustomFormat {
  String priceWithCurrency(double price) {
    var c = Get.find<MainController>().appCurrency.value;

    return '${c.code} ${((price) * (c.rate ?? 0)).toStringAsFixed(2).replaceAll('.0', '')}';
  }
}
