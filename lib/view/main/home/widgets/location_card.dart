import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:erbil/utilities/custom_bottom_sheet.dart';
import 'package:erbil/view/main/home/widgets/locations_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'pick_up_location'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              AppFunctions().onPressedWithHaptic(() {
                CustomBottomSheet().dragAbleBottomSheet(LocationsBottomSheet(
                  onTap: (l) {
                    mainController.selectLocation(l);
                    Get.back();
                  },
                ));
              });
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius, side: const BorderSide()),
              child: Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(mainController.pickupLocation.value.isEmpty
                    ? 'select'.tr
                    : mainController.pickupLocation.value),
              ),
            ),
          )
        ],
      ),
    );
  }
}
