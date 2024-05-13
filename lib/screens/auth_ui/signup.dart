import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/textformfield_customized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui/homepage.dart';
import '../widgets/confirm_password_textfield.dart';
import '../widgets/elevatedbutton_customised.dart';
import '../widgets/password_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
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
          const TextFormFieldCustomized(
            hintText: "Enter your full name",
            icon: Icon(Icons.person),
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 30.h,
          ),
          const TextFormFieldCustomized(
              hintText: "Enter your location",
              icon: Icon(Icons.person_pin_circle),
              keyboardType: TextInputType.text),
          SizedBox(
            height: 30.h,
          ),
          const TextFormFieldCustomized(
              hintText: "Enter your email address",
              icon: Icon(Icons.email),
              keyboardType: TextInputType.emailAddress),
          SizedBox(
            height: 30.h,
          ),
          const TextFormFieldCustomized(
              hintText: "Enter your phone number",
              icon: Icon(Icons.phone),
              keyboardType: TextInputType.phone),
          SizedBox(
            height: 30.h,
          ),
          PasswordTextField(
            passwordController: _passController,
            isObscure: true,
            hintText: 'Enter your password',
          ),
          SizedBox(
            height: 30.h,
          ),
          ConfirmPasswordTextField(
            passwordController: _confirmPassController,
            isObscure: true,
            hintText: 'Confirm your password',
            confirmPasswordController: _passController,
          ),
          SizedBox(
            height: 43.h,
          ),
           Center(child: ElevatedButtonCustomised(onPressed: () {
            Get.to(const HomePage());
          }, text: "Create an Account",)),
        ],
      )),
    );
  }
}
