import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: CupertinoSearchTextField(
                    borderRadius: BorderRadius.circular(25),
                    prefixInsets: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12.5),
                    placeholder: 'search'.tr,
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // List<CarModel> cars = snapshot.data!.docs
                    //     .map((m) => CarModel.fromMap(m.data() as Map, m.id))
                    //     .toList();

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: 0,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return null;

                        // CarModel car = cars[index];
                        // return CarCard(carData: car);
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
