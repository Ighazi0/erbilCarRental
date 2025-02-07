import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/view/car/car_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
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
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: controller,
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
                stream: FirebaseFirestore.instance
                    .collection('cars')
                    .where('status', isEqualTo: 'available')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CarModel> cars = snapshot.data!.docs
                        .map((m) => CarModel.fromMap(m.data() as Map, m.id))
                        .toList();
                    List<CarModel> result = cars
                        .where((w) =>
                            (w.name?.removeAllWhitespace.toLowerCase().contains(controller.text.removeAllWhitespace.toLowerCase()) ?? false) ||
                            (w.year?.removeAllWhitespace.toLowerCase().contains(controller.text.removeAllWhitespace.toLowerCase()) ??
                                false) ||
                            (w.transmission?.removeAllWhitespace
                                    .toLowerCase()
                                    .contains(controller.text.removeAllWhitespace
                                        .toLowerCase()) ??
                                false) ||
                            (w.color?.removeAllWhitespace.toLowerCase().contains(
                                    controller.text.removeAllWhitespace
                                        .toLowerCase()) ??
                                false) ||
                            (w.fuelType?.removeAllWhitespace
                                    .toLowerCase()
                                    .contains(controller.text.removeAllWhitespace
                                        .toLowerCase()) ??
                                false))
                        .toList();
                    if (result.isEmpty) {
                      return Center(
                        child: Text('no_data_found'.tr),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: result.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        CarModel car = result[index];
                        return CarCard(carData: car);
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
