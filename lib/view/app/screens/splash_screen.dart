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
    await Future.delayed(const Duration(milliseconds: 500));
    var uid = GetStorage().read('uid');
    if (uid == null) {
      await Future.delayed(const Duration(seconds: 1));
    } else {
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
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}