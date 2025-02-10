import 'package:erbil/model/car_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/custom_ui/custom_format.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
import 'package:erbil/view/car/car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarCard extends StatelessWidget {
  final CarModel carData;

  const CarCard({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CarDetailsScreen(carData: carData));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: borderRadius, boxShadow: show, color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carData.name ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${carData.seats} ${'doors'.tr} | ${carData.seats} ${'seats'.tr}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        carData.transmission?.tr ?? '',
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        carData.year ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: Color(int.tryParse(
                                    '0xff${carData.color?.replaceFirst('#', '')}') ??
                                00000)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 125,
                    width: Get.width / 2.25,
                    child: CustomImage(
                      url: carData.images?.firstOrNull ?? '',
                      boxFit: BoxFit.fitWidth,
                    )),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_gas_station),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('same_to_same'.tr),
                  ],
                ),
                Obx(() {
                  return Text(
                    '${CustomFormat().priceWithCurrency(carData.price ?? 0)}/${'day'.tr}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
