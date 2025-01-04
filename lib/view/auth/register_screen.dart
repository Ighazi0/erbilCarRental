import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 50),
                child: Text(
                  'sign_up'.tr,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: authController.name,
                decoration: InputDecoration(
                  labelText: 'full_name'.tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                decoration: InputDecoration(
                  labelText: 'email_address'.tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                ),
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
              const SizedBox(height: 20),
              Obx(
                () => authController.signingUp.value
                    ? const CircularProgressIndicator()
                    : Hero(
                        tag: 'auth',
                        child: CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authController.registerWithEmailAndPassword();
                            }
                          },
                          title: 'sign_up',
                        ),
                      ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already_have_an_account'.tr),
                  TextButton(
                    onPressed: () {
                      Get.off(() => const SignInScreen());
                    },
                    child: Text(
                      'sign_in'.tr,
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
    );
  }
}
