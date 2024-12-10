import 'package:cached_network_image/cached_network_image.dart';
import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/static_data.dart';
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
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var category = categories[index];
                return GestureDetector(
                  child: SizedBox(
                    height: 75,
                    width: 150,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 75,
                              width: 150,
                              child: CachedNetworkImage(
                                  imageUrl: category.image ?? '')),
                          Text(
                            category.title?.tr ?? '',
                            maxLines: 2,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
