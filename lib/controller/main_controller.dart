import 'dart:convert';
import 'package:erbil/model/weather_model.dart';
import 'package:erbil/utilities/end_points.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/utilities/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MainController extends GetxController {
  RxInt mainPageIndex = 0.obs;
  Rx<WeatherModel> weatherData = WeatherModel().obs;
  Rx<DateTime> pickupDate = DateTime.now().obs, returnDate = DateTime.now().obs;

  RxString pickupLocation = ''.obs;
  final RxList<DateTime> selectedDateRange = <DateTime>[].obs;

  @override
  onInit() {
    fetchWeather();
    super.onInit();
  }

  changeMainPage(int newIndex) {
    mainPageIndex.value = newIndex;
  }

  Stream<DateTime> getTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  selectLocation(String newLocation) {
    pickupLocation.value = newLocation;
  }

  selectPickUpDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
        context: context, initialDate: pickupDate.value);
    if (dateTime != null) {
      pickupDate.value = dateTime;
    }

    checkDates();
  }

  selectReturnDateTime(BuildContext context) async {
    DateTime? dateTime = await showOmniDateTimePicker(
        context: context, initialDate: returnDate.value);
    if (dateTime != null) {
      returnDate.value = dateTime;
    }

    checkDates();
  }

  checkDates() {
    if (pickupDate.value.isAfter(returnDate.value)) {
      returnDate.value = pickupDate.value;
    }
  }

  fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
          '${EndPoints().openWeatherMapApi}q=Dubai&appid=$weatherApiKey&units=metric&lang=$appLanguage'));
      if (response.statusCode == 200) {
        weatherData.value = WeatherModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      //
    }
  }
}
