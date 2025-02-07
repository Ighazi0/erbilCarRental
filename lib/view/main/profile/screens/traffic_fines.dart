import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrafficFines extends StatelessWidget {
  const TrafficFines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'traffic_fines'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text(
            'traffic_fines_1'.tr,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'traffic_fines_2'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'traffic_fines_3'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'traffic_fines_4'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'traffic_fines_5'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'traffic_fines_6'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'traffic_fines_7'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'traffic_fines_8'.tr,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          Text(
            'traffic_fines_9'.tr,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
