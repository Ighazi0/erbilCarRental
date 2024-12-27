import 'package:cached_network_image/cached_network_image.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarCard extends StatelessWidget {
  final CarModel carData;

  const CarCard({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius, boxShadow: show, color: Colors.white),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              child: SizedBox(
                  height: 200,
                  width: Get.width,
                  child: CachedNetworkImage(
                    imageUrl: carData.images?.firstOrNull ?? '',
                    fit: BoxFit.fill,
                  )),
            ),
            ListTile(
              title: Text(carData.name ?? ''),
              subtitle: Text(
                carData.year ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('data'),
                  Obx(() {
                    var c = Get.find<MainController>().appCurrency.value;
                    return Text(
                      '${c.code} ${((carData.price ?? 0) * (c.rate ?? 0)).toStringAsFixed(2).replaceAll('.0', '')}/${'day'.tr}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
