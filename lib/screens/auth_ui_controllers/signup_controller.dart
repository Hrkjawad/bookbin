import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth_ui/verify_code.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import 'auth_service.dart';

final _auth = AuthService();
signup(
    GlobalKey<FormState> formKey,
    TextEditingController email,
    TextEditingController password,
    TextEditingController confirmPassword,
    TextEditingController phone,
    TextEditingController fullName,
    TextEditingController location) async {
  final formController = Get.find<FormController>();
  if (formKey.currentState?.validate() ?? false) {
    if (password.text != confirmPassword.text) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
      formController.setLoading(false);
      return;
    }
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email.text,
        password.text,
      );
      if (user != null) {
        FirebaseFirestore.instance.collection('UserInfo').doc(user.uid).set({
          'Full_Name': fullName.text,
          'Location': location.text,
          'Email': email.text,
          'Phone': phone.text,
          'UserUID': user.uid,
          'profileURL': "",
        });
        Get.snackbar("Success", "Please verify your email first",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        formController.setLoading(false);
        await Future.delayed(const Duration(seconds: 2));
        Get.to(VerificationCode(email: email.text));
        fullName.clear();
        location.clear();
        phone.clear();
        password.clear();
        confirmPassword.clear();
        email.clear();
      } else {
        Get.snackbar("Sign up failed", "This email already has account",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        formController.setLoading(false);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to store in Firebase: $e",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      formController.setLoading(false);
    }
  }
  formController.setLoading(false);
}
