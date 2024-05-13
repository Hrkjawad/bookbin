import 'package:BookBin/screens/auth_ui/signup_verification_code.dart';
import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/textformfield_customized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/confirm_password_textfield.dart';
import '../widgets/elevatedbutton_customised.dart';
import '../widgets/password_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const BackButtonAndLogo(),
            SizedBox(
              height: 42.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 31.w),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 43.h,
            ),
            TextFormFieldCustomized(
              hintText: "Enter your full name",
              icon: const Icon(Icons.person),
              keyboardType: TextInputType.text,
              controller: _fullName,
            ),
            SizedBox(
              height: 30.h,
            ),
            TextFormFieldCustomized(
                controller: _location,
                hintText: "Enter your location",
                icon: const Icon(Icons.person_pin_circle),
                keyboardType: TextInputType.text),
            SizedBox(
              height: 30.h,
            ),
            TextFormFieldCustomized(
                controller: _email,
                hintText: "Enter your email address",
                icon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress),
            SizedBox(
              height: 30.h,
            ),
            TextFormFieldCustomized(
                controller: _phone,
                hintText: "Enter your phone number",
                icon: const Icon(Icons.phone),
                keyboardType: TextInputType.phone),
            SizedBox(
              height: 30.h,
            ),
            PasswordTextField(
              passwordController: _password,
              isObscure: true,
              hintText: 'Enter your password',
            ),
            SizedBox(
              height: 30.h,
            ),
            ConfirmPasswordTextField(
              passwordController: _password,
              isObscure: true,
              hintText: 'Confirm your password',
              confirmPasswordController: _confirmPassword,
            ),
            SizedBox(
              height: 43.h,
            ),
            Center(
                child: ElevatedButtonCustomised(
              onPressed: () {
                Get.to(const SignupVerificationCode());
              },
              text: "Create an Account",
            )),
          ],
        ),
      )),
    );
  }
}
