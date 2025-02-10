import 'package:erbil/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key, this.controller, required this.labelText, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      controller: controller,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        labelText: labelText.tr,
        labelStyle: const TextStyle(color: primaryColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
      ),
      validator: validator,
    );
  }
}
