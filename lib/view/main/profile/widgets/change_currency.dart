import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/utilities/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeCurrency extends StatelessWidget {
  const ChangeCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: currencies
            .map(
              (m) => ListTile(
                onTap: () {
                  AppFunctions().onPressedWithHaptic(() {
                    AppFunctions().changeCurrency(m.keys.first);
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
                          color: appCurrency == m.keys.first
                              ? primaryColor
                              : Colors.transparent),
                      child: Text(
                        m.keys.first.tr,
                        style: TextStyle(
                            color: appCurrency == m.keys.first
                                ? secondaryColor
                                : primaryColor),
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
