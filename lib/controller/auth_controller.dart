import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erbil/model/app_data_model.dart';
import 'package:erbil/model/user_model.dart';
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
  UserModel? userData;
  AppDataModel? appData;

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
        userData = UserModel.fromJson(v.data() as Map);
      } else {
        signOut();
      }
    });
  }

  createUserAccount(String uid, UserModel userData) async {
    await firebaseFirestore.collection('users').doc(uid).set(userData.toJson());
  }

  signInWithEmailAndPassword() async {
    signingIn.value = true;
    await firebaseAuth.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    String uid = firebaseAuth.currentUser?.uid ?? '';
    await getCurrentUserData(uid);
    getStorage.write('uid', uid);
    Get.offAll(() => const MainScreen());
    clearData();
  }

  registerWithEmailAndPassword() async {
    signingUp.value = true;
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    String uid = firebaseAuth.currentUser?.uid ?? '';
    userData = UserModel(
        uid: uid,
        email: email.text,
        password: password.text,
        fullName: name.text);
    Get.offAll(() => const MainScreen());
    createUserAccount(uid, userData!);
    getStorage.write('uid', uid);
    clearData();
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
    await firebaseAuth.sendPasswordResetEmail(email: email.text);
    clearData();
  }

  clearData() {
    email.clear();
    name.clear();
    password.clear();
    signingIn.value = false;
    signingUp.value = false;
    deletingAccount.value = false;
    sendingLink.value = false;
  }

  signOut() async {
    getStorage.remove('uid');
    userData = null;
    await firebaseAuth.signOut();
    Get.offAll(() => const MainScreen());
  }
}
