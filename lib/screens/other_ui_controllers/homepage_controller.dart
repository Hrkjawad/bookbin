import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final storage = GetStorage();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  var greeting = ''.obs;
  var userFullName = ''.obs;
  var userEmail = ''.obs;
  var userLocation = ''.obs;
  var userPhone = ''.obs;
  var userUID = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchUserInfo(user.uid);
        setStatus("Online", user.uid);
      }
    });

    _updateGreeting();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateGreeting();
    });
  }

  void setStatus(String status, String uid) async {
    if (uid.isNotEmpty) {
      await _firebaseFirestore.collection("UserInfo")
          .where('UserUID', isEqualTo: uid)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.first.reference.update({'status': status});
        }
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        if (state == AppLifecycleState.resumed) {
          setStatus("Online", user.uid);
        } else {
          setStatus("Offline", user.uid);
        }
      }
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 22 || hour < 6) {
      greeting.value = "It's Sleep Time";
    } else if (hour < 12) {
      greeting.value = 'Good Morning';
    } else if (hour < 17) {
      greeting.value = 'Good Afternoon';
    } else {
      greeting.value = 'Good Evening';
    }
  }

  void fetchUserInfo(String uid) async {
    try {
      userUID.value = uid;
      storage.write("UID", uid);

      var userSnapshot = await FirebaseFirestore.instance
          .collection("UserInfo")
          .where("UserUID", isEqualTo: uid)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userData = userSnapshot.docs.first.data();

        storage.write("Full_Name", userData['Full_Name'] ?? 'No Name found');
        storage.write("Email", userData['Email'] ?? 'No Email found');
        storage.write("Location", userData['Location'] ?? 'No Location found');
        storage.write("Phone", userData['Phone'] ?? 'No Phone found');

        userFullName.value = userData['Full_Name'] ?? 'No Name found';
        userEmail.value = userData['Email'] ?? 'No Email found';
        userLocation.value = userData['Location'] ?? 'No Location found';
        userPhone.value = userData['Phone'] ?? 'No Phone found';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user info: $e');
      }
    }
  }
}
