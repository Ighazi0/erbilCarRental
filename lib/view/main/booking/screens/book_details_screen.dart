import 'package:erbil/model/car_model.dart';
import 'package:erbil/model/location_model.dart';
import 'package:erbil/model/order_model.dart';
import 'package:erbil/utilities/custom_ui/custom_format.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookDetailsScreen extends StatelessWidget {
  final OrderModel orderData;
  const BookDetailsScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'book_details'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Text(
            '#${orderData.id}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: FutureBuilder(
                  future: orderData.car?.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      CarModel car = CarModel.fromMap(
                          snapshot.data?.data() as Map,
                          snapshot.data?.reference);
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(car.name ?? '',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(car.year ?? '',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: Get.width / 2.5,
                              child: CustomImage(
                                  url: car.images?.firstOrNull ?? ''),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                )),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
            future: orderData.location?.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                LocationModel location = LocationModel.fromMap(
                    snapshot.data?.data() as Map, snapshot.data?.reference);
                return _buildInfoRow(
                    "pick_up_location",
                    (appLanguage == 'en' ? location.nameEn : location.nameAr) ??
                        '');
              }
              return const SizedBox();
            },
          ),
          _buildInfoRow(
              "pick_up",
              DateFormat('dd-MM-yyyy')
                  .format(orderData.from?.toDate() ?? DateTime.now())),
          _buildInfoRow(
              "return",
              DateFormat('dd-MM-yyyy')
                  .format(orderData.to?.toDate() ?? DateTime.now())),
          const Divider(
            thickness: 1,
          ),
          _buildInfoRow(
              "price_per_day",
              CustomFormat().priceWithCurrency(
                  (orderData.totalPrice ?? 0) / (orderData.days ?? 0))),
          _buildInfoRow("days", orderData.days.toString()),
          _buildInfoRow("total",
              CustomFormat().priceWithCurrency(orderData.totalPrice ?? 0),
              isBold: true),
        ],
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(label.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    ),
  );
}
