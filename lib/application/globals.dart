import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  // Reactive variables with initial empty string values.
  var userFullName = ''.obs;
  var userEmail = ''.obs;
  var userLocation = ''.obs;
  var userPhone = ''.obs;

  // User UID as an observable string.
  var userUID = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  // Function to fetch and update user information.
  Future<void> fetchUserInfo() async {
    try {
      // Ensure that the user is logged in before proceeding.
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (kDebugMode) {
          print('No user is currently signed in.');
        }
        return;
      }

      userUID.value = user.uid; // Store the UID in an observable.

      // Fetch user data from Firestore based on the UID.
      var userSnapshot = await FirebaseFirestore.instance
          .collection("UserInfo")
          .where("UserUID", isEqualTo: userUID.value)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userData = userSnapshot.docs.first.data();

        // Update the observables with user data.
        userFullName.value = userData['Full_Name'] ?? 'No Name found';
        userEmail.value = userData['Email'] ?? 'No Email found';
        userLocation.value = userData['Location'] ?? 'No location found';
        userPhone.value = userData['Phone'] ?? 'No Phone Number';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user info: $e');
      }
    }
  }
}
