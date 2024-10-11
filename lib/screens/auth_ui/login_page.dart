import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../auth_ui_controllers/login_controller.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/TextFields/password_textfield.dart';
import '../widgets/TextFields/textformfield_customized.dart';
import 'forgotpass_verification_code.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                controller: _email,
                hintText: "Enter your email address",
                icon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "Please fill this";
                  }
                  if (email.length < 5) {
                    return "Please enter a email address";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              PasswordTextField(
                passwordController: _password,
                hintText: 'Enter your password',
              ),
              SizedBox(
                height: 65.h,
              ),
              Center(
                child: ElevatedButtonCustomised(
                  onPressed: () => login(_formKey, _email, _password),
                  text: "Login",
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(const Verification(
                      check: true,
                    ));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
