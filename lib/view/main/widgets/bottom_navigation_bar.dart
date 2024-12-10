import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatNavigationBar extends StatelessWidget {
  const FloatNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: 10,
      bottom: 10,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customIcon(Icons.home, 'home'.tr, 0),
              customIcon(Icons.search, 'search'.tr, 1),
              customIcon(Icons.paste, 'bookings'.tr, 2),
              customIcon(Icons.person, 'profile'.tr, 3)
            ],
          ),
        ),
      ),
    );
  }
}

Widget customIcon(IconData icon, String title, int index) {
  final mainController = Get.find<MainController>();
  return GestureDetector(
      onTap: () {
        AppFunctions().onPressedWithHaptic(() {
          mainController.changeMainPage(index);
        });
      },
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon,
                color: mainController.mainPageIndex.value == index
                    ? primaryColor
                    : thirdColor),
            Text(
              title.tr,
              style: TextStyle(
                  color: mainController.mainPageIndex.value == index
                      ? primaryColor
                      : thirdColor,
                  fontWeight: mainController.mainPageIndex.value == index
                      ? FontWeight.bold
                      : null),
            )
          ],
        ),
      ));
}
