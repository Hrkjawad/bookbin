import 'package:BookBin/screens/welcome_screen.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/welcome_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    goToNextScreen();
    super.initState();
  }

  void goToNextScreen() {
    Future.delayed(const Duration(seconds: 3)).then(
          (value) => Get.offAll(
            () => const WelcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:  ScreenBackground(
          child: Column(
            children: [
              SizedBox(height: 300,),
              Center(child: WelcomeLogo()),
              Spacer(),
              CircularProgressIndicator(
                color: Color(0xFFA158AD),
              ),
              SizedBox(height: 8,),
              Text("Version 1.0", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 32,),
            ],
          ),
        )
    );
  }
}
