import 'package:erbil/model/order_model.dart';
import 'package:erbil/view/main/booking/screens/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookCard extends StatelessWidget {
  final OrderModel orderData;
  const BookCard({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => BookDetailsScreen(orderData: orderData));
      },
      title: Text('#${orderData.id}'),
    );
  }
}
