import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/utilities/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLangauge extends StatelessWidget {
  const ChangeLangauge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: languages
            .map(
              (m) => ListTile(
                onTap: () {
                  AppFunctions().onPressedWithHaptic(() {
                    Get.find<MainController>().changeLocale(m.keys.first);
                    Get.back();
                  });
                },
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          color: appLanguage == m.keys.first
                              ? primaryColor
                              : Colors.transparent),
                      child: Text(
                        m.keys.first.tr,
                        style: TextStyle(
                            color: appLanguage == m.keys.first
                                ? secondaryColor
                                : Colors.black),
                      ),
                    ),
                  ],
                ),
                leading: Text(
                  m.values.first,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            )
            .toList());
  }
}
