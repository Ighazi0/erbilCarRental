import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  showAlertDialog() {}

  showSureDialog(String title, String content, String buttonTitle,
      {bool barrierDismissible = true, Function? onPressed}) {
    Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          if (title.isNotEmpty)
            Text(
              title.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          if (content.isNotEmpty) Text(content.tr),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: Text(
              'no'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            )),
        TextButton(
            onPressed: () {
              if (onPressed == null) {
                Get.back();
              } else {
                onPressed();
              }
            },
            child: Text(
              buttonTitle.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ))
      ],
    );
  }
}
