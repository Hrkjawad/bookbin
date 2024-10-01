import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userLocation = '';
String userEmail = '';
String userFullName = '';
String userPhone = '';
String userUID = '';
Future<void> fetchUserInfo() async {
  userUID = FirebaseAuth.instance.currentUser!.uid;
  try {
    var userSnapshot = await FirebaseFirestore.instance
        .collection("UserInfo")
        .where("UserUID", isEqualTo: userUID)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      var userData = userSnapshot.docs.first.data();

      userLocation = userData['Location'] ?? 'No location found';
      userEmail = userData['Email'] ?? 'No Email found';
      userFullName = userData['Full_Name'] ?? 'No Name found';
      userPhone = userData['Phone'] ?? 'No Phone Number';
    }
  } catch (e) {
    userFullName = 'Error in fetching';
  }
}