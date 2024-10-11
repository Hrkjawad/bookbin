import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile, String userId) async {
    try {
      String fileName = 'profilePic.jpg';
      Reference storageRef =
      _firebaseStorage.ref().child('userProfiles/$userId/$fileName');

      // Upload the file (this will overwrite any existing file with the same name)
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      Get.snackbar(
        "", "Error uploading image to Firebase",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
