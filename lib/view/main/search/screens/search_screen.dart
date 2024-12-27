import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/model/car_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                    FirebaseFirestore.instance.collection('cars').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CarModel> cars = snapshot.data!.docs
                        .map((m) => CarModel.fromMap(m.data() as Map, m.id))
                        .toList();

                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: cars.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        CarModel car = cars[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              boxShadow: show,
                              color: Colors.white),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(25)),
                                child: SizedBox(
                                    height: 200,
                                    width: Get.width,
                                    child: CachedNetworkImage(
                                      imageUrl: car.images?.firstOrNull ?? '',
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              ListTile(
                                title: Text(car.name ?? ''),
                                subtitle: Text(
                                  car.year ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  thickness: 1,
                                  height: 0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('data'),
                                    Text(
                                      '$appCurrency ${car.price.toString().replaceAll('.0', '')}/${'day'.tr}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
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
