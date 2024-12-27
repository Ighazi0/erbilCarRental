import 'package:erbil/utilities/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

String appLanguage = 'en';

class InitialData {
  initialApp() async {
    await GetStorage.init();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    getSavedLocale();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  getSavedLocale() {
    String? locale = GetStorage().read('locale');
    appLanguage = locale ?? Get.deviceLocale?.languageCode ?? 'en';
  }
}
