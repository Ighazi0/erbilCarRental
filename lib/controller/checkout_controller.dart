import 'dart:convert';

import 'package:dio/dio.dart' as api_dio;
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/model/location_model.dart';
import 'package:erbil/model/paymob_model.dart';
import 'package:erbil/utilities/custom_ui/custom_snackbar.dart';
import 'package:erbil/view/checkout/widgets/paymob_webview.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  String? token;
  RxBool booking = false.obs;
  PaymobModel? paymobData;
  MainController mainController = Get.find<MainController>();
  Rx<DateTime> pickupDate = DateTime.now().obs,
      returnDate = DateTime.now().add(const Duration(days: 7)).obs;
  Rx<LocationModel?> pickupLocation = LocationModel().obs;
  Rx<CarModel> selectedCar = CarModel().obs;

  @override
  onInit() {
    selectedCar = mainController.selectedCar;
    pickupLocation = mainController.pickupLocation;
    pickupDate = mainController.pickupDate;
    returnDate = mainController.returnDate;
    super.onInit();
  }

  int calculateDays() {
    return (returnDate.value.difference(pickupDate.value)).inDays;
  }

  generatePaymobToken() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"username": "501357705", "password": "Dara@1991"});
    var dio = api_dio.Dio();
    var response = await dio.request(
      'https://uae.paymob.com/api/auth/tokens',
      options: api_dio.Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      token = response.data['token'];
    } else {
      CustomSnackbar().showErrorSnackbar('error1${response.data}');
    }
  }

  generatePaymobLink() async {
    if (token != null) {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var data = api_dio.FormData.fromMap({
        'amount_cents': '100',
        'payment_methods': '59440',
        'is_live': 'true'
      });

      var dio = api_dio.Dio();
      var response = await dio.request(
        'https://uae.paymob.com/api/ecommerce/payment-links',
        options: api_dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        paymobData = PaymobModel.fromJson(response.data);
      } else {
        CustomSnackbar().showErrorSnackbar('error${response.data}');
      }
    }
  }

  createNewOrder() {}

  book() async {
    try {
      booking.value = true;
      await generatePaymobToken();
      await generatePaymobLink();
      if (paymobData != null) {
        Get.to(() => PaymobWebview(
              link: paymobData?.clientUrl ?? '',
            ));
      }
    } catch (e) {
      CustomSnackbar().showErrorSnackbar('error3 $e');
    }
    booking.value = false;
  }
}
