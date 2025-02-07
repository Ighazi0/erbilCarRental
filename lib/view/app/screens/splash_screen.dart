import 'package:erbil/controller/auth_controller.dart';
import 'package:erbil/view/main/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startApp() async {
    var uid = GetStorage().read('uid');
    if (uid == null) {
      await Get.find<AuthController>().getAppData();
    } else {
      await Get.find<AuthController>().getAppData();
      await Get.find<AuthController>().getCurrentUserData(uid);
    }
    Get.off(() => const MainScreen());
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 200,
        ),
      ),
    );
  }
}
