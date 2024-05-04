import 'package:BookBin/screens/splash_screen.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookBin extends StatelessWidget {
  const BookBin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: MaterialColor(
            AppMainColor.primaryColor.value, AppMainColor().color),
      ),
    );
  }
}
