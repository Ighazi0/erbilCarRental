import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/custom_ui/custom_format.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
import 'package:erbil/view/checkout/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarModel carData;
  const CarDetailsScreen({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    if (mainController.selectedCar.value.docRef == null) {
      mainController.selectedCar.value = carData;
    }
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 75,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomButton(
              title: '',
              titleWidget: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'rent'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    Obx(() {
                      return Text(
                        '${CustomFormat().priceWithCurrency(mainController.calculateTotal())} / ${'days'.tr}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      );
                    })
                  ],
                ),
              ),
              onPressed: () {
                Get.to(() => const CheckoutScreen());
              }),
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
                              boxFit: BoxFit.fitWidth,
                            ))
                        .toList() ??
                    [],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      return Text(
                        '${CustomFormat().priceWithCurrency(carData.price ?? 0)} / ${'day'.tr}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 7.5,
                    children: [
                      Text(
                        carData.year.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(
                        Icons.fiber_manual_record_rounded,
                        color: primaryColor,
                        size: 15,
                      ),
                      Text(
                        '${carData.seats} ${'seats'.tr}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(
                        Icons.fiber_manual_record_rounded,
                        size: 15,
                        color: primaryColor,
                      ),
                      Text(
                        carData.transmission?.tr ?? '',
                        style: const TextStyle(fontSize: 16),
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
                      carData.fuelType ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      ' / ${'same_to_same'.tr}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        'color'.tr,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 25,
                        height: 25,
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
                  'features'.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 7.5,
                    runSpacing: 5,
                    children:
                        List.generate(carData.features?.length ?? 0, (index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            carData.features?[index].toString().tr ?? '',
                          ),
                          if (index != ((carData.features?.length ?? 0) - 1))
                            const SizedBox(
                              width: 7.5,
                            ),
                          if (index != ((carData.features?.length ?? 0) - 1))
                            const Icon(
                              Icons.fiber_manual_record_rounded,
                              color: primaryColor,
                              size: 15,
                            )
                        ],
                      );
                    }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
