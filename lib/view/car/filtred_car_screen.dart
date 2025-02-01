import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/model/category_model.dart';
import 'package:erbil/model/location_model.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/view/car/car_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FiltredCarScreen extends StatelessWidget {
  final LocationModel? locationData;
  final CategoryModel? categoryData;
  const FiltredCarScreen({super.key, this.categoryData, this.locationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLanguage == 'en'
              ? categoryData?.titleEn ?? ''
              : categoryData?.titleAr ?? '',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: locationData == null
              ? FirebaseFirestore.instance
                  .collection('cars')
                  .where('status', isEqualTo: 'available')
                  .where('type', isEqualTo: categoryData?.docRef)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('cars')
                  .where('status', isEqualTo: 'available')
                  .where('location', isEqualTo: locationData?.docRef)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CarModel> cars = snapshot.data!.docs
                  .map((m) => CarModel.fromMap(m.data() as Map, m.id))
                  .toList();
              if (cars.isEmpty) {
                return Center(
                  child: Text('no_data_found'.tr),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                padding: const EdgeInsets.only(top: 10),
                itemCount: cars.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  CarModel car = cars[index];
                  return CarCard(carData: car);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
