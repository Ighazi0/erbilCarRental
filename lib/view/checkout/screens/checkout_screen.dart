import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/controller/checkout_controller.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:erbil/utilities/custom_ui/custom_format.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
import 'package:erbil/view/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      init: CheckoutController(),
      builder: (checkoutController) {
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 75,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: checkoutController.booking
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : CustomButton(
                      title: 'book_now',
                      onPressed: () {
                        if (Get.find<AuthController>().userData.value.docRef ==
                            null) {
                          Get.to(() => const SignInScreen(
                                toCheckoutScreen: true,
                              ));
                        } else {
                          checkoutController.book();
                        }
                      }),
            ),
          ),
          appBar: AppBar(
            title: Text(
              'checkout'.tr,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                checkoutController.selectedCar.value.name ?? '',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                checkoutController.selectedCar.value.year ?? '',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: Get.width / 2.5,
                          child: CustomImage(
                              url: checkoutController
                                      .selectedCar.value.images?.firstOrNull ??
                                  ''),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildInfoRow(
                  "pick_up_location",
                  (appLanguage == 'en'
                          ? checkoutController.pickupLocation.value?.nameEn
                          : checkoutController.pickupLocation.value?.nameAr) ??
                      ''),
              _buildInfoRow(
                  "pick_up",
                  DateFormat('dd-MM-yyyy')
                      .format(checkoutController.pickupDate.value), change: () {
                checkoutController.selectPickUpDateTime(context);
              }),
              _buildInfoRow(
                  "return",
                  DateFormat('dd-MM-yyyy')
                      .format(checkoutController.returnDate.value), change: () {
                checkoutController.selectReturnDateTime(context);
              }),
              const Divider(
                thickness: 1,
              ),
              _buildInfoRow(
                  "price_per_day",
                  CustomFormat().priceWithCurrency(
                      checkoutController.selectedCar.value.price ?? 0)),
              _buildInfoRow(
                  "days", checkoutController.calculateDays().toString()),
              _buildInfoRow(
                  "total",
                  CustomFormat()
                      .priceWithCurrency(checkoutController.calculateTotal()),
                  isBold: true),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildInfoRow(String label, String value,
    {bool isBold = false, Function? change}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(label.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (change != null)
          InkWell(
              onTap: () {
                AppFunctions().onPressedWithHaptic(() {
                  change();
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'change'.tr,
                  style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              )),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    ),
  );
}
