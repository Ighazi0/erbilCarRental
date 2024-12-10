import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CupertinoSearchTextField(
            borderRadius: BorderRadius.circular(25),
            prefixInsets: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
            placeholder: 'search'.tr,
          ),
          // StreamBuilder(stream: FirebaseFirestore.instance.collection('cars'), builder: builder)
        ],
      ),
    );
  }
}
