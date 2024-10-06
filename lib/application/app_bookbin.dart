import 'package:BookBin/application/getx_controllers.dart';
import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:BookBin/screens/splash_screen.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookBin extends StatelessWidget {
  const BookBin({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: user == null ? const SplashScreen() : const HomePage(),
        initialBinding: GetXBindings(),
        theme: ThemeData(
          textTheme: TextTheme(
            titleMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
            )
          ),
          iconTheme: const IconThemeData(
            color: Color(0xff8847a1),
          ),
          useMaterial3: false,
          primarySwatch: MaterialColor(
              AppMainColor.primaryColor.value, AppMainColor().color),
        ),
      ),
    );
  }
}
