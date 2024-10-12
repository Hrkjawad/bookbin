import 'dart:io';
import 'homepage_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../application/firebase_stroage_services.dart';
import '../../application/image_picker_services.dart';

class ProfileController extends GetxController {
  final ImagePickerService _imagePickerService = ImagePickerService();
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  final storage = GetStorage();


  Future<void> pickAndUploadImage(String userId) async {
    File? pickedImage = await _imagePickerService
        .pickImageFromGallery(); // or pickImageFromCamera()

    if (pickedImage != null) {
      Get.snackbar(
        "Uploading", "",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5)
      );
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final userController = Get.find<HomeController>();
      String? downloadUrl = await _firebaseStorageService.uploadImage(pickedImage, userId);
      if (downloadUrl != null) {
        userController.profileURL.value = "";
        storage.remove("profileURL");
        userController.profileURL.value = downloadUrl;

        await firebaseFirestore
            .collection('UserInfo')
            .where("UserUID", isEqualTo: userController.userUID.value)
            .get()
            .then((querySnapshot) {
          if(querySnapshot.docs.isNotEmpty){
            querySnapshot.docs.first.reference.update({'profileURL': userController.profileURL.value });
          }
        });

      } else {
        Get.snackbar(
         "", "Failed to get the download URL.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "", "No image selected.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
