import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppFunctions {
  onPressedWithHaptic(Function f) {
    HapticFeedback.mediumImpact();
    f();
  }

  Future<DateTime> selectDate(DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      return picked;
    } else {
      return selectedDate;
    }
  }

  Future<TimeOfDay> selectTime(TimeOfDay selectedTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
    );

    if (picked != null) {
      return picked;
    } else {
      return selectedTime;
    }
  }
}
