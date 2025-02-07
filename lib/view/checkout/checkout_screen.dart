import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'checkout'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: const [],
      ),
    );
  }
}
