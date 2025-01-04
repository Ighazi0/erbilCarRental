import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/auth/forgot_password_screen.dart';
import 'package:erbil/view/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                TextFormField(
                  controller: authController.email,
                  decoration: InputDecoration(
                    labelText: 'email_address'.tr,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
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
                TextFormField(
                  controller: authController.password,
                  decoration: InputDecoration(
                    labelText: 'password'.tr,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
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
                Obx(() => authController.signingIn.value
                    ? const CircularProgressIndicator()
                    : Hero(
                        tag: 'auth',
                        child: CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authController.signInWithEmailAndPassword();
                            }
                          },
                          title: 'sign_in',
                        ),
                      )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dont_have_an_account".tr),
                    TextButton(
                      onPressed: () {
                        Get.off(() => const RegisterScreen());
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
