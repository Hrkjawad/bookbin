import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/textformfield_customized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui/homepage.dart';
import '../widgets/elevatedbutton_customised.dart';
import '../widgets/password_textfield.dart';
import 'forgotten_verification_send.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
              height: 96.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 31.w),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 65.h,
            ),
             TextFormFieldCustomized(
               controller: _name,
              hintText: "Enter your email address",
              icon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 40.h,
            ),
            PasswordTextField(
              passwordController: _password,
              isObscure: true,
              hintText: 'Enter your password',
            ),
            SizedBox(
              height: 65.h,
            ),
            Center(
              child: ElevatedButtonCustomised(
                onPressed: () {
                  Get.to( HomePage());
                },
                text: "Login",
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(const Verification());
                },
                child:  Text(
                  'Forgotten Password?',
                  style: TextStyle(
                      fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            )
                    ],
                  ),
          )),
    );
  }
}
