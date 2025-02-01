import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/car/filtred_car_screen.dart';
import 'package:erbil/view/main/home/widgets/categories_card.dart';
import 'package:erbil/view/main/home/widgets/location_card.dart';
import 'package:erbil/view/main/home/widgets/pick_date_time_card.dart';
import 'package:erbil/view/main/home/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${'hello'.tr}${authController.userData?.fullName == null ? '' : ', '} ${authController.userData?.fullName ?? ''}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              const WeatherCard(),
              const CategoriesCard(),
              const LocationCard(),
              const PickDateTimeCard(),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                onPressed: () {
                  final mainController = Get.find<MainController>();
                  if (mainController.pickupLocation.value.docRef == null) {
                  } else {
                    Get.to(() => FiltredCarScreen(
                          locationData: mainController.pickupLocation.value,
                        ));
                  }
                },
                title: 'search',
              )
            ],
          ),
        ));
  }
}
