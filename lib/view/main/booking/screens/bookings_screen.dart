import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/model/order_model.dart';
import 'package:erbil/view/app/widgets/custom_button.dart';
import 'package:erbil/view/auth/sign_in_screen.dart';
import 'package:erbil/view/main/booking/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            authController.userData.value.docRef == null
                ? Center(
                    child: Column(
                      children: [
                        Text(
                          'you_are_not_logged_in_please_sign_in_to_continue'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () {
                            Get.to(() => const SignInScreen());
                          },
                          width: Get.width / 2,
                          title: 'sign_in',
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .where('user',
                              isEqualTo: authController.userData.value.docRef)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<OrderModel> orders = snapshot.data!.docs
                              .map((m) => OrderModel.fromJson(
                                    m.data() as Map,
                                  ))
                              .toList();
                          if (orders.isEmpty) {
                            return Center(
                              child: Text('no_data_found'.tr),
                            );
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: orders.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              OrderModel order = orders[index];
                              return OrderCard(
                                orderData: order,
                              );
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
