import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PickDateTimeCard extends StatelessWidget {
  const PickDateTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'pick_up_return_dates'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: borderRadius, side: const BorderSide()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              AppFunctions().onPressedWithHaptic(() async {
                                mainController.selectPickUpDateTime(context);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'pick_up'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            mainController.pickupDate.value),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat('EE, hh:mm a').format(
                                        mainController.pickupDate.value),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              AppFunctions().onPressedWithHaptic(() {
                                mainController.selectReturnDateTime(context);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'return'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            mainController.returnDate.value),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat('EE, hh:mm a').format(
                                        mainController.returnDate.value),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
