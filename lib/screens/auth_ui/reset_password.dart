import 'package:BookBin/screens/auth_ui/login_page.dart';
import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/confirm_password_textfield.dart';
import '../widgets/elevatedbutton_customised.dart';
import '../widgets/password_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 42.h,
              ),
              Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 44.h,
              ),
              SizedBox(
                width: 288.w,
                child: Text(
                  "Use at least 8 characters one uppercase letter one lowercase letter and one number in your password",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF595959),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              PasswordTextField(
                passwordController: _passController,
                isObscure: true,
                hintText: 'Enter your password',
              ),
              SizedBox(
                height: 29.h,
              ),
              ConfirmPasswordTextField(
                passwordController: _confirmPassController,
                isObscure: true,
                hintText: 'Confirm your password',
                confirmPasswordController: _passController,
              ),
              SizedBox(
                height: 54.h,
              ),
              Center(
                  child: ElevatedButtonCustomised(
                onPressed: () {
                  Get.to(const LoginPage());
                },
                text: "Reset",
              )),
            ],
          ),
        ],
      )),
    );
  }
}
