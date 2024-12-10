import 'package:flutter/material.dart';
import 'package:get/get.dart';

ScrollController customScrollController = ScrollController();

class CustomBottomSheet {
  simpleBottomSheet(Widget widget) async {
    await Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
        child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [SafeArea(child: widget)])),
      ),
      isScrollControlled: true,
    );
  }

  dragAbleBottomSheet(Widget widget) async {
    await Get.bottomSheet(
      DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.85,
        initialChildSize: 0.85,
        builder: (context, scrollController) {
          customScrollController = scrollController;
          return Container(
              padding:
                  EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: widget);
        },
      ),
      isScrollControlled: true,
    );
  }
}
