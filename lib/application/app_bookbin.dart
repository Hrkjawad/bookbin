import 'package:BookBin/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BookBin extends StatelessWidget {
  const BookBin({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

