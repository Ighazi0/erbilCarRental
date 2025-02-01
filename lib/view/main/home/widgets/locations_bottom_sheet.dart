import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/model/location_model.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationsBottomSheet extends StatelessWidget {
  final Function onTap;
  const LocationsBottomSheet({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('locations').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<LocationModel> locations = snapshot.data!.docs
                  .map((m) => LocationModel.fromMap(m.data(), m.reference))
                  .toList();
              if (locations.isEmpty) {
                return Align(
                  child: Text(
                    'no_data'.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Column(
                children: [
                  // if (locations.isNotEmpty)
                  //   CupertinoSearchTextField(
                  //     borderRadius: BorderRadius.circular(25),
                  //     prefixInsets: const EdgeInsets.only(left: 15),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 15, vertical: 12.5),
                  //     placeholder: 'search'.tr,
                  //   ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 1,
                        ),
                        physics: const ClampingScrollPhysics(),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          LocationModel location = locations[index];
                          return ListTile(
                            onTap: () {
                              AppFunctions().onPressedWithHaptic(() {
                                onTap(location);
                              });
                            },
                            title: Text(
                              location.nameEn ?? '',
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }
            return const Align(child: CircularProgressIndicator());
          },
        ));
  }
}
