import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as api_dio;
import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/model/location_model.dart';
import 'package:erbil/model/order_model.dart';
import 'package:erbil/model/paymob_model.dart';
import 'package:erbil/utilities/custom_ui/custom_snackbar.dart';
import 'package:erbil/view/checkout/widgets/paymob_webview.dart';
import 'package:erbil/view/main/booking/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CheckoutController extends GetxController {
  String? token;
  bool booking = false, success = false;
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

  selectPickUpDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
        context: context, initialDate: pickupDate.value);
    if (dateTime != null) {
      pickupDate.value = dateTime;
      update();
    }

    checkDates();
  }

  selectReturnDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
        context: context, initialDate: returnDate.value);
    if (dateTime != null) {
      returnDate.value = dateTime;
      update();
    }

    checkDates();
  }

  checkDates() {
    if (pickupDate.value.isAfter(returnDate.value)) {
      returnDate.value = pickupDate.value;
    }
  }

  double calculateTotal() {
    return (selectedCar.value.price ?? 0) * calculateDays();
  }

  int calculateDays() {
    return returnDate.value.day - pickupDate.value.day;
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
        'amount_cents': (calculateTotal() * 100).toString(),
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

  createNewOrder() async {
    OrderModel orderData = OrderModel(
        car: selectedCar.value.docRef,
        id: paymobData?.id,
        updatedAt: Timestamp.now(),
        days: calculateDays(),
        user: Get.find<AuthController>().userData?.docRef,
        from: Timestamp.fromDate(pickupDate.value),
        to: Timestamp.fromDate(returnDate.value),
        location: selectedCar.value.location,
        totalPrice: calculateTotal(),
        createdAt: Timestamp.now());
    await FirebaseFirestore.instance
        .collection('orders')
        .add(orderData.toJson());
    Get.offUntil(
      GetPageRoute(
          page: () => OrderDetailsScreen(
                orderData: orderData,
              )),
      (route) {
        return route.isFirst;
      },
    );
    success = false;
    booking = false;
  }

  book() async {
    try {
      booking = true;
      update();
      await generatePaymobToken();
      await generatePaymobLink();
      if (paymobData != null) {
        await Get.to(() => PaymobWebview(
              link: paymobData?.clientUrl ?? '',
              checkoutController: this,
            ));
        if (success) {
          await createNewOrder();
        } else {
          booking = false;
          update();
        }
      }
    } catch (e) {
      CustomSnackbar().showErrorSnackbar('error3 $e');
      booking = false;
      update();
    }
  }
}
