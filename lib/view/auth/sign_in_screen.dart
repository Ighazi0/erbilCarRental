import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/app/widgets/custom_text_field.dart';
import 'package:erbil/view/auth/forgot_password_screen.dart';
import 'package:erbil/view/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  final bool toCheckoutScreen;
  const SignInScreen({super.key, this.toCheckoutScreen = false});

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
                    'sign_in'.tr,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextField(
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
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'password',
                  controller: authController.password,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'password_must_be_at_least_6_characters'.tr;
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: Text(
                      'forgot_password'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                Obx(() => Center(
                      child: authController.signingIn.value
                          ? const CircularProgressIndicator(
                              color: primaryColor,
                            )
                          : Hero(
                              tag: 'auth',
                              child: CustomButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    authController.signInWithEmailAndPassword(
                                        toCheckoutScreen: toCheckoutScreen);
                                  }
                                },
                                title: 'sign_in',
                              ),
                            ),
                    )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dont_have_an_account".tr),
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        Get.off(() => RegisterScreen(
                              toCheckoutScreen: toCheckoutScreen,
                            ));
                      },
                      child: Text(
                        'sign_up'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Align(
                  child: TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
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
        ),
      ),
    );
  }
}
