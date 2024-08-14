import 'package:BookBin/screens/auth_ui/verify_code.dart';
import 'package:BookBin/screens/auth_ui_controllers/signup_controller.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/TextFields/confirm_password_textfield.dart';
import '../widgets/TextFields/password_textfield.dart';
import '../widgets/TextFields/textformfield_customized.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullName.dispose();
    _location.dispose();
    _emailController.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

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
              SizedBox(height: 42.h),
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
              SizedBox(height: 43.h),
              TextFormFieldCustomized(
                hintText: "Enter your full name",
                icon: const Icon(Icons.person),
                keyboardType: TextInputType.text,
                controller: _fullName,
                validator: (fullName){
                  if (fullName == null || fullName.isEmpty) {
                    return "Please fill this";
                  }
                  if (fullName.length < 4) {
                    return "Enter your full Name";
                  }
                  return null;
                }
              ),
              SizedBox(height: 30.h),
              TextFormFieldCustomized(
                controller: _location,
                hintText: "Enter your location",
                icon: const Icon(Icons.person_pin_circle),
                keyboardType: TextInputType.text,
                validator: (location) {
                  if (location == null || location.isEmpty) {
                    return "Please fill this";
                  }
                  if (location.length < 5) {
                    return "Enter your current location";
                  }
                  return null;
                }
              ),
              SizedBox(height: 30.h),
              TextFormFieldCustomized(
                controller: _emailController,
                hintText: "Enter your email address",
                icon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "Please fill this";
                  }
                  if (email.length < 5) {
                    return "Enter your real email";
                  }
                  return null;
                }
              ),
              SizedBox(height: 30.h),
              TextFormFieldCustomized(
                controller: _phone,
                hintText: "Enter your phone number",
                icon: const Icon(Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (number) {
                  if (number == null || number.isEmpty) {
                    return "Please fill this";
                  }
                  if (number.length != 11) {
                    return "Please enter a 11-digit phone Number";
                  }
                  final numValue = int.tryParse(number);
                  if (numValue == null) {
                    return "Please enter a valid number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              PasswordTextField(
                passwordController: _password,
                hintText: 'Enter your password',
              ),
              SizedBox(height: 30.h),
              ConfirmPasswordTextField(
                passwordController: _password,
                hintText: 'Confirm your password',
                confirmPasswordController: _confirmPassword,
              ),
              SizedBox(height: 43.h),
              Center(
                child: ElevatedButtonCustomised(
                  onPressed: _signup,
                  text: _isLoading ? "Loading..." : "Create an Account",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_password.text != _confirmPassword.text) {
        Get.snackbar("Error", "Passwords do not match",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      setState(() {
        _isLoading = true;
      });

      try {
        final user = await _auth.createUserWithEmailAndPassword(
          _emailController.text, _password.text,
        );
        if (user != null) {
          CollectionReference collRef = FirebaseFirestore.instance.collection('UserInfo');
          await collRef.add({
            'Full_Name': _fullName.text,
            'Location': _location.text,
            'Email': _emailController.text,
            'Phone': _phone.text,
          });
          Get.snackbar("Success", "User Created successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          await Future.delayed(const Duration(seconds: 2));
          Get.to( VerificationCode(email: _emailController.text));
          _fullName.clear();
          _location.clear();
          _phone.clear();
          _password.clear();
          _confirmPassword.clear();
          _emailController.clear();

        } else {
          Get.snackbar("Sign up failed", "This email already has account",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to store in Firebase: $e",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}