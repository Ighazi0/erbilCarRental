import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarModel carData;
  const CarDetailsScreen({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 75,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
              title: '',
              titleWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'rent'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    Obx(() {
                      var c = Get.find<MainController>().appCurrency.value;
                      return Text(
                        '${c.code} ${((carData.price ?? 0) * (c.rate ?? 0)).toStringAsFixed(2).replaceAll('.0', '')}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    })
                  ],
                ),
              ),
              onPressed: () {}),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 250,
              width: Get.width,
              child: PageView(
                children: carData.images
                        ?.map((m) => CustomImage(
                              url: m,
                              boxFit: BoxFit.fill,
                            ))
                        .toList() ??
                    [],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      carData.name ?? '',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Obx(() {
                      var c = Get.find<MainController>().appCurrency.value;
                      return Text(
                        '${c.code} ${((carData.price ?? 0) * (c.rate ?? 0)).toStringAsFixed(2).replaceAll('.0', '')}/${'day'.tr}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      Text(
                        carData.year.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Icon(
                        Icons.fiber_manual_record_rounded,
                        size: 20,
                      ),
                      Text(
                        '${carData.seats} ${'seats'.tr}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Icon(
                        Icons.fiber_manual_record_rounded,
                        size: 20,
                      ),
                      Text(
                        carData.transmission?.tr ?? '',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_gas_station),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'same_to_same'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        'color'.tr,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: Color(int.tryParse(
                                    '0xff${carData.color?.replaceFirst('#', '')}') ??
                                00000)),
                      ),
                    ],
                  ),
                ),
                Text(
                  carData.description ?? '',
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
