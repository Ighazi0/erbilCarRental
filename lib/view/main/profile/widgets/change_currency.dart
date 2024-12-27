import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/currency_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeCurrency extends StatelessWidget {
  const ChangeCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    List<CurrencyModel> data =
        Get.find<AuthController>().appData!.currencies ?? [];
    return Column(
        children: data
            .map(
              (m) => ListTile(
                onTap: () {
                  AppFunctions().onPressedWithHaptic(() {
                    Get.find<MainController>().changeCurrency(m);
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
                          color: Get.find<MainController>()
                                      .appCurrency
                                      .value
                                      .code ==
                                  m.code.toString()
                              ? primaryColor
                              : Colors.transparent),
                      child: Text(
                        m.code.toString().tr,
                        style: TextStyle(
                            color: Get.find<MainController>()
                                        .appCurrency
                                        .value
                                        .code ==
                                    m.code.toString()
                                ? secondaryColor
                                : primaryColor),
                      ),
                    ),
                  ],
                ),
                leading: Text(
                  m.flag ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            )
            .toList());
  }
}
