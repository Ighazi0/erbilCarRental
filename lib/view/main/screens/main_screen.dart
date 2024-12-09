import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/view/main/profile/screens/profile_screen.dart';
import 'package:erbil/view/main/home/screens/home_screen.dart';
import 'package:erbil/view/main/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => SafeArea(
                child: IndexedStack(
                    index: mainController.mainPageIndex.value,
                    children: const [
                      HomeScreen(),
                      HomeScreen(),
                      ProfileScreen(),
                      ProfileScreen(),
                    ]),
              )),
          const FloatNavigationBar()
        ],
      ),
    );
  }
}
