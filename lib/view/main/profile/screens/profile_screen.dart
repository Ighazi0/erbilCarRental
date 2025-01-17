import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/custom_ui/custom_bottom_sheet.dart';
import 'package:erbil/utilities/custom_ui/custom_dialog.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/view/auth/sign_in_screen.dart';
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
            authController.userData?.firstName ?? '',
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
              CustomBottomSheet().simpleBottomSheet(
                const ChangeCurrency(),
              );
            },
            trailing: Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: primaryColor),
                  child: Text(
                    Get.find<MainController>().appCurrency.value.code ?? '',
                    style: TextStyle(color: secondaryColor),
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
                style: TextStyle(color: secondaryColor),
              ),
            ),
            onTap: () {
              CustomBottomSheet().simpleBottomSheet(
                const ChangeLangauge(),
              );
            },
            leading: const Icon(Icons.language),
          ),
          ListTile(
            onTap: () {
              if (authController.userData == null) {
                Get.to(() => const SignInScreen());
              } else {
                CustomDialog().showSureDialog(
                    'are_you_sure_to_sign_out', '', 'yes', onPressed: () {
                  authController.signOut();
                });
              }
            },
            title: Text(
              authController.userData == null ? 'sign_in'.tr : 'sign_out'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: authController.userData == null
                      ? Colors.black
                      : Colors.red),
            ),
            leading: Icon(
              authController.userData == null ? Icons.login : Icons.logout,
              color:
                  authController.userData == null ? Colors.black : Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
