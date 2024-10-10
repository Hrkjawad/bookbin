import 'package:BookBin/application/app_bookbin.dart';
//import 'package:BookBin/application/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await NotificationServices.initializeNotifications();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(
    const SafeArea(
      child: BookBin(),
    ),
  );
}
