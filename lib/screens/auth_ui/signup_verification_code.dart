import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui/homepage.dart';
import '../widgets/elevatedbutton_customised.dart';
import 'package:pinput/pinput.dart';

class SignupVerificationCode extends StatefulWidget {
  const SignupVerificationCode({super.key});

  @override
  State<SignupVerificationCode> createState() => _SignupVerificationCodeState();
}

class _SignupVerificationCodeState extends State<SignupVerificationCode> {
  String email = "emailaddress@gmail.com";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      body: ScreenBackground(
        child: ListView(
          shrinkWrap: true,
          children: [
            const BackButtonAndLogo(),
            SizedBox(
              height: 42.h,
            ),
            Center(
              child: Text(
                "Enter Verification Code",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            Text(
              "Enter code that we have sent to your",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF595959),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppMainColor.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.black),
                  ),
                ),
                onCompleted: (pin) => debugPrint(pin),
              ),
            ),
            SizedBox(height: 23.sp,),
            Text(
              "Didn't you receive any code?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF595959),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            TextButton(
              onPressed: (){},
             child: Text ("Resend a new code",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppMainColor.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Center(
                child: ElevatedButtonCustomised(
              onPressed: () {
                Get.to(const HomePage());
              },
              text: "Verify",
            )),
          ],
        ),
      ),
    );
  }
}
