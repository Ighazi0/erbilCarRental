import 'package:erbil/style/app_theme.dart';
import 'package:erbil/utilities/custom_binding.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/utilities/locale/app_localization.dart';
import 'package:erbil/view/app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(appLanguage),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: primaryColor),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false)),
      translations: LanguageLocalization(),
      home: const SplashScreen(),
      initialBinding: MainBinding(),
    );
  }
}
