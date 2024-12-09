import 'package:erbil/utilities/firebase/firebase_options.dart';
import 'package:erbil/utilities/initial_data.dart';
import 'package:erbil/utilities/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  InitialData().initialApp();
  runApp(const MyApp());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
}
