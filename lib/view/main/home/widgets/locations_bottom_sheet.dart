import 'package:erbil/utilities/app_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationsBottomSheet extends StatelessWidget {
  final Function onTap;
  const LocationsBottomSheet({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(
        children: [
          CupertinoSearchTextField(
            placeholder: 'search'.tr,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    AppFunctions().onPressedWithHaptic(() {
                      onTap(index.toString());
                    });
                  },
                  title: Text(index.toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
