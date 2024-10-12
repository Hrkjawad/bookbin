import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile, String userId) async {
    try {
      // Compress the image to WebP format before uploading
      File? compressedImage = await _compressImageToWebP(imageFile);
      if (compressedImage == null) {
        Get.snackbar(
          "", "Error compressing image",
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }

      String fileName = 'profilePic.webp'; // Save as WebP format
      Reference storageRef = _firebaseStorage.ref().child('userProfiles/$userId/$fileName');

      // Upload the compressed WebP file
      UploadTask uploadTask = storageRef.putFile(compressedImage);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar(
        "", "Error uploading image to Firebase: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<File?> _compressImageToWebP(File file) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String targetPath = path.join(tempDir.path, '${path.basenameWithoutExtension(file.path)}.webp');

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        format: CompressFormat.webp,
        quality: 2,
      );

      // Ensure the result is a File
      return result != null ? File(result.path) : null;
    } catch (e) {
      Get.snackbar(
        "", "Error compressing image to WebP: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
