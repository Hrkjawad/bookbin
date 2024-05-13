import 'package:BookBin/screens/auth_ui/forgot_pass_verification.dart';
import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/textformfield_customized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/elevatedbutton_customised.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _SignupState();
}

class _SignupState extends State<Verification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Form(
            key: _formKey,
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            const BackButtonAndLogo(),
            SizedBox(
              height: 42.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 31.w),
              child: Text(
                "Verification",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 31.w),
              child: Text(
                "A code will be sent to your email address",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF595959),
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
             TextFormFieldCustomized(
               controller: _email,
                hintText: "Enter your email address",
                icon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress),
            SizedBox(
              height: 80.h,
            ),
            Center(
                child: ElevatedButtonCustomised(
              onPressed: () {
                Get.to(
                    const ForgotPassVerification()
                );
              },
              text: "Send",
            ),
            ),
                    ],
                  ),
          ),
      ),
    );
  }
}
