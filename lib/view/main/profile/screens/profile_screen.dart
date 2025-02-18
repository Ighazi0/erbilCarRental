import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:erbil/utilities/custom_ui/custom_bottom_sheet.dart';
import 'package:erbil/utilities/custom_ui/custom_dialog.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/view/auth/sign_in_screen.dart';
import 'package:erbil/view/main/profile/screens/traffic_fines.dart';
import 'package:erbil/view/main/profile/widgets/change_currency.dart';
import 'package:erbil/view/main/profile/widgets/change_langauge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            authController.userData.value.firstName ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListTile(
            title: Text(
              'currency'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              AppFunctions().onPressedWithHaptic(() {
                CustomBottomSheet().simpleBottomSheet(
                  const ChangeCurrency(),
                );
              });
            },
            trailing: Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: primaryColor),
                  child: Text(
                    Get.find<MainController>().appCurrency.value.code ?? '',
                    style: const TextStyle(color: secondaryColor),
                  ),
                )),
            leading: const Icon(Icons.currency_exchange),
          ),
          ListTile(
            title: Text(
              'language'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: borderRadius, color: primaryColor),
              child: Text(
                appLanguage.tr,
                style: const TextStyle(color: secondaryColor),
              ),
            ),
            onTap: () {
              AppFunctions().onPressedWithHaptic(() {
                CustomBottomSheet().simpleBottomSheet(
                  const ChangeLangauge(),
                );
              });
            },
            leading: const Icon(Icons.language),
          ),
          ListTile(
            title: Text(
              'traffic_fines'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
            ),
            onTap: () {
              AppFunctions().onPressedWithHaptic(() {
                Get.to(() => const TrafficFines());
              });
            },
            leading: const Icon(Icons.directions),
          ),
          ListTile(
            onTap: () {
              AppFunctions().onPressedWithHaptic(() {
                if (authController.userData.value.docRef == null) {
                  Get.to(() => const SignInScreen());
                } else {
                  CustomDialog().showSureDialog(
                      'are_you_sure_to_sign_out', '', 'yes', onPressed: () {
                    authController.signOut();
                  });
                }
              });
            },
            title: Text(
              authController.userData.value.docRef == null
                  ? 'sign_in'.tr
                  : 'sign_out'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: authController.userData.value.docRef == null
                      ? primaryColor
                      : Colors.red),
            ),
            leading: Icon(
              authController.userData.value.docRef == null
                  ? Icons.login
                  : Icons.logout,
              color: authController.userData.value.docRef == null
                  ? primaryColor
                  : Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
