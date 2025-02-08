import 'package:dio/dio.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/model/currency_model.dart';
import 'package:erbil/model/location_model.dart';
import 'package:erbil/model/weather_model.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:erbil/utilities/end_points.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/utilities/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MainController extends GetxController {
  RxInt mainPageIndex = 0.obs;
  Rx<WeatherModel> weatherData = WeatherModel().obs;
  Rx<DateTime> pickupDate = DateTime.now().obs,
      returnDate = DateTime.now().add(const Duration(days: 7)).obs;
  Rx<CurrencyModel> appCurrency = CurrencyModel(code: 'AED', rate: 1).obs;
  Rx<LocationModel> pickupLocation = LocationModel().obs;
  Rx<CarModel> selectedCar = CarModel().obs;

  @override
  onInit() {
    fetchWeather();
    getSavedCurrency();
    super.onInit();
  }

  int calculateDays() {
    return (returnDate.value.difference(pickupDate.value)).inDays;
  }

  getSavedCurrency() {
    Map? currency = GetStorage().read('currency');
    if (currency != null) {
      appCurrency.value = CurrencyModel.fromMap(currency);
    }
  }

  changeLocale(String locale) {
    AppFunctions().onPressedWithHaptic(() {
      GetStorage().write('locale', locale);
      Get.updateLocale(Locale(locale));
      appLanguage = locale;
    });
  }

  changeCurrency(CurrencyModel currency) {
    AppFunctions().onPressedWithHaptic(() {
      GetStorage().write('currency', currency.toMap());
      appCurrency.value = currency;
    });
  }

  changeMainPage(int newIndex) {
    mainPageIndex.value = newIndex;
  }

  Stream<DateTime> getTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  selectLocation(LocationModel newLocation) {
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
      final response = await Dio().get(
          '${EndPoints().openWeatherMapApi}q=Dubai&appid=$weatherApiKey&units=metric&lang=$appLanguage');
      if (response.statusCode == 200) {
        weatherData.value = WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      Get.log('fetchWeather :: $e');
    }
  }
}
