import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth_ui/login_page.dart';
import '../auth_ui/verify_code.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';

final auth = FirebaseAuth.instance;
emailCheck(
    GlobalKey<FormState> formKey, TextEditingController email, check) async {
  final formController = Get.find<FormController>();
  if (formKey.currentState!.validate()) {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    final QuerySnapshot result = await firebase
        .collection('UserInfo')
        .where('Email', isEqualTo: email.text)
        .get();
    if (result.docs.isNotEmpty) {
      if (check == true) {
        auth.sendPasswordResetEmail(email: email.text).then((value) async {
          Get.snackbar("Account Found", "A reset link was send into your email",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          formController.setLoading(false);
          await Future.delayed(const Duration(seconds: 2));
          Get.to(const LoginPage());
          email.clear();
        });
      } else {
        Get.snackbar("Found", "This email has account",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        formController.setLoading(false);
        await Future.delayed(const Duration(seconds: 2));
        Get.to(VerificationCode(email: email.text));
        email.clear();
      }
    } else {
      Get.snackbar("Not Found", "This email has no account",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      formController.setLoading(false);
      email.clear();
    }
  }
  formController.setLoading(false);
}
