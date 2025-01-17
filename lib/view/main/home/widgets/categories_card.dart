import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/model/category_model.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/view/app/widgets/custom_image.dart';
import 'package:erbil/view/app/widgets/shimmer_effect.dart';
import 'package:erbil/view/car/filtred_car_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'categories'.tr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 125,
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('types').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoryModel> categories = snapshot.data!.docs
                        .map((m) =>
                            CategoryModel.fromJson(m.data() as Map, m.id))
                        .toList();
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        CategoryModel category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => const FiltredCarScreen());
                          },
                          child: SizedBox(
                            height: 75,
                            width: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: borderRadius),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 75,
                                      width: 150,
                                      child: CustomImage(
                                          url: category.image ?? '')),
                                  Text(
                                    category.titleEn?.tr ?? '',
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return ShimmerEffect(
                    isLoading: true,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: SizedBox(
                            height: 75,
                            width: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: borderRadius),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
