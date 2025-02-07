import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 50),
                child: Text(
                  'reset_password'.tr,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'enter_your_email_address_to_reset_your_password.we_will_send_a_password_reset_link_to_your_email'
                    .tr,
                style: const TextStyle(fontSize: 16),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: CustomTextField(
                    labelText: 'email_address',
                    controller: authController.email,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                        return 'please_enter_your_email'.tr;
                      }

                      return null;
                    },
                  )),
              Obx(() => authController.sendingLink.value
                  ? const CircularProgressIndicator(
                      color: primaryColor,
                    )
                  : Hero(
                      tag: 'auth',
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            authController.resetPassword();
                          }
                        },
                        title: 'send_reset_link',
                      ),
                    )),
              Align(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'back'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
