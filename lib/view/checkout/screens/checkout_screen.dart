import 'package:erbil/controller/checkout_controller.dart';
import 'package:erbil/utilities/custom_ui/custom_format.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
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
              child: CustomButton(
                  title: 'book_now',
                  onPressed: () {
                    checkoutController.book();
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
                      .format(checkoutController.pickupDate.value)),
              _buildInfoRow(
                  "return",
                  DateFormat('dd-MM-yyyy')
                      .format(checkoutController.returnDate.value)),
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
                  CustomFormat().priceWithCurrency(
                      (checkoutController.selectedCar.value.price ?? 0) *
                          checkoutController.calculateDays()),
                  isBold: true),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    ),
  );
}
