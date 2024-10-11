import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../other_ui/homepage.dart';
import '../other_ui_controllers/homepage_controller.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import 'auth_service.dart';

final _auth = AuthService();
login(GlobalKey<FormState> formKey, TextEditingController email,
    TextEditingController password) async {
  final formController = Get.find<FormController>();
  if (formKey.currentState!.validate()) {
    final user =
        await _auth.loginUserWithEmailAndPassword(email.text, password.text);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await firebaseFirestore
        .collection("UserInfo")
        .where("Email", isEqualTo: email.text)
        .get();
    try {
      if (user != null && result.docs.isNotEmpty) {
        Get.snackbar("Login", "User Logged In Successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await Future.delayed(const Duration(seconds: 2));
        formController.setLoading(false);
        Get.put(HomeController());
        Get.offAll(const HomePage());
        email.clear();
        password.clear();
      } else {
        Get.snackbar("User not found", "Email or Password are not matched",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        formController.setLoading(false);
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetching user info.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
      formController.setLoading(false);
    }
  }
  formController.setLoading(false);
}
