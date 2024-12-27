import 'dart:ui';

import 'package:erbil/utilities/initial_data.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppFunctions {
  onPressedWithHaptic(Function f) {
    HapticFeedback.mediumImpact();
    f();
  }

  changeLocale(String locale) {
    onPressedWithHaptic(() {
      GetStorage().write('locale', locale);
      Get.updateLocale(Locale(locale));
      appLanguage = locale;
    });
  }

  changeCurrency(String currency) {
    onPressedWithHaptic(() {
      GetStorage().write('currency', currency);
      appCurrency = currency;
    });
  }
}
