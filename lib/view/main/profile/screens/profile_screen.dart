import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/utilities/custom_ui/custom_dialog.dart';
import 'package:erbil/view/auth/sign_in_screen.dart';
import 'package:erbil/view/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(
            'https://via.placeholder.com/150',
          ),
        ),
        Text(
          authController.userData?.firstName ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          title: Text(
            'settings'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Get.to(() => const SettingsScreen());
          },
          leading: const Icon(Icons.settings),
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
            color: authController.userData == null ? Colors.black : Colors.red,
          ),
        )
      ],
    );
  }
}
