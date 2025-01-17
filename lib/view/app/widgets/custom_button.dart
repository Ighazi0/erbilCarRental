import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Widget? titleWidget;
  final double? width;
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.title = '',
      this.width,
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: MaterialButton(
        onPressed: () {
          AppFunctions().onPressedWithHaptic(() async {
            onPressed();
          });
        },
        minWidth: width ?? Get.width,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: primaryColor,
        child: titleWidget ??
            Text(
              title.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
      ),
    );
  }
}
