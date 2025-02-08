import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/controller/main_controller.dart';
import 'package:erbil/model/app_data_model.dart';
import 'package:erbil/model/user_model.dart';
import 'package:erbil/utilities/custom_ui/custom_snackbar.dart';
import 'package:erbil/view/main/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      password = TextEditingController();
  RxBool signingIn = false.obs,
      signingUp = false.obs,
      sendingLink = false.obs,
      deletingAccount = false.obs;
  GetStorage getStorage = GetStorage();
  Rx<UserModel> userData = UserModel().obs;
  AppDataModel? appData;
  final mainController = Get.find<MainController>();

  getAppData() async {
    await firebaseFirestore.collection('appData').doc('admin').get().then((v) {
      if (v.exists) {
        appData = AppDataModel.fromJson(v.data() as Map);
      } else {
        signOut();
      }
    });
  }

  getCurrentUserData(String? uid) async {
    await firebaseFirestore.collection('users').doc(uid).get().then((v) {
      if (v.exists) {
        userData.value = UserModel.fromJson(v.data() as Map, v.reference);
      } else {
        signOut();
      }
    });
  }

  createUserAccount(String uid, UserModel userData) async {
    await firebaseFirestore.collection('users').doc(uid).set(userData.toJson());
  }

  signInWithEmailAndPassword({bool toCheckoutScreen = false}) async {
    signingIn.value = true;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      String uid = firebaseAuth.currentUser?.uid ?? '';
      await getCurrentUserData(uid);
      getStorage.write('uid', uid);
      if (toCheckoutScreen) {
        Get.back();
      } else {
        mainController.mainPageIndex.value = 0;
        Get.offAll(() => const MainScreen());
      }
      clearData();
    } catch (e) {
      CustomSnackbar().showErrorSnackbar('error');
    }
    signingIn.value = false;
  }

  registerWithEmailAndPassword({bool toCheckoutScreen = false}) async {
    signingUp.value = true;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      String uid = firebaseAuth.currentUser?.uid ?? '';
      userData.value = UserModel(
          uid: uid,
          email: email.text,
          password: password.text,
          fullName: name.text);
      if (toCheckoutScreen) {
        Get.back();
      } else {
        mainController.mainPageIndex.value = 0;
        Get.offAll(() => const MainScreen());
      }
      createUserAccount(uid, userData.value);
      getStorage.write('uid', uid);
      clearData();
    } catch (e) {
      CustomSnackbar().showErrorSnackbar('error');
    }
    signingIn.value = false;
  }

  deleteAccount(String uid) async {
    deletingAccount.value = true;
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({'deleted': true});
    clearData();
    signOut();
  }

  resetPassword() async {
    sendingLink.value = true;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.text);
    } catch (e) {
      CustomSnackbar().showErrorSnackbar('error');
    }
    clearData();
  }

  clearData() {
    email.clear();
    name.clear();
    password.clear();
    deletingAccount.value = false;
    sendingLink.value = false;
  }

  signOut() async {
    getStorage.remove('uid');
    userData = UserModel().obs;
    await firebaseAuth.signOut();
    Get.offAll(() => const MainScreen());
  }
}
