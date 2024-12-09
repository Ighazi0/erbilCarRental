import 'package:erbil/controller/auth_controller.dart';
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
            '${'hello'.tr} ${authController.userData?.fullName == null ? '' : ', '} ${authController.userData?.fullName ?? ''}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: const [
            WeatherCard(),
            CategoriesCard(),
            PickDateTimeCard(),
            LocationCard()
          ],
        ));
  }
}
