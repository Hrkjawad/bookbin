import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utilitis/app_main_color.dart';
import '../../other_ui/book_details.dart';
import '../../other_ui_controllers/homepage_controller.dart';
import '../../welcome_screen.dart';

Drawer customDrawer(BuildContext context) {
  final HomeController userController = Get.put(HomeController());
  return Drawer(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60.w, bottom: 15.w),
          child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.w),
                color: AppMainColor.primaryColor,
              ),
              height: 80.h,
              width: 80.w,
              child: Icon(
                Icons.person,
                size: 60.w,
                color: Colors.white,
              )),
        ),
        Obx(
          () => Text(
            userController.userFullName.toString(),
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppMainColor.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        ListTile(
          title: Obx(
            () => Text(
              userController.userEmail.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          leading: Icon(
            Icons.email_rounded,
            color: AppMainColor.primaryColor,
          ),
        ),
        ListTile(
          title: Obx(
            () => Text(
              userController.userLocation.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          leading: Icon(
            Icons.location_on_sharp,
            color: AppMainColor.primaryColor,
          ),
        ),
        ListTile(
          title: Obx(
            () => Text(
              userController.userPhone.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          leading: Icon(
            Icons.phone,
            color: AppMainColor.primaryColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.w, bottom: 25.w),
          child: SizedBox(
            width: 250.w,
            height: 60.h,
            child: ElevatedButton(
                onPressed: () {
                  myBookList(context);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Colors.white70,
                    side: BorderSide(color: AppMainColor.primaryColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w))),
                child: Text(
                  "My Added BookLists",
                  style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      color: AppMainColor.primaryColor),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.w),
          child: SizedBox(
            width: 250.w,
            height: 60.h,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 2,
                    side: BorderSide(color: AppMainColor.primaryColor),
                    backgroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w))),
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppMainColor.primaryColor),
                )),
          ),
        ),
        TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Are you sure?",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () async {
                                final storage = GetStorage();
                                final HomeController control = Get.find<HomeController>();
                                await FirebaseAuth.instance
                                    .signOut()
                                    .then((value) {
                                  control.userUID.value = '';
                                  control.userFullName.value = '';
                                  control.userEmail.value = '';
                                  control.userLocation.value = '';
                                  control.userPhone.value = '';
                                  storage.remove("UID");
                                  storage.remove("Full_Name");
                                  storage.remove("Email");
                                  storage.remove("Location");
                                  storage.remove("Phone");
                                  storage.erase();
                                  Get.snackbar(
                                      "You are successfully logout", "",
                                      snackPosition: SnackPosition.BOTTOM);
                                  Get.offAll(const WelcomePage());
                                });
                              },
                              icon: Icon(
                                Icons.check_box,
                                color: AppMainColor.primaryColor,
                                size: 40.w,
                              )),
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.black45,
                                size: 40.w,
                              ))
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.w),
                      ),
                    );
                  });
            },
            child: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ))
      ],
    ),
  );
}

void myBookList(BuildContext context) {
  List<CollectionReference> collections = [
    FirebaseFirestore.instance.collection('Business'),
    FirebaseFirestore.instance.collection('Health'),
    FirebaseFirestore.instance.collection('Novels'),
    FirebaseFirestore.instance.collection('Language'),
    FirebaseFirestore.instance.collection('History'),
    FirebaseFirestore.instance.collection('CSE'),
    FirebaseFirestore.instance.collection('Education'),
    FirebaseFirestore.instance.collection('Science')
  ];

  String userUID = FirebaseAuth.instance.currentUser!.uid;

  List<Stream<QuerySnapshot>> streams = collections.map((collection) {
    return collection.where('listerUID', isEqualTo: userUID).snapshots();
  }).toList();

  Stream<List<QuerySnapshot>> combinedStream =
      CombineLatestStream.list(streams);

  combinedStream.listen((List<QuerySnapshot> snapshotList) {
    List<DocumentSnapshot> documents =
        snapshotList.expand((querySnapshot) => querySnapshot.docs).toList();

    if (documents.isEmpty) {
      _showNoBooksDialog(context);
    } else {
      _showBookListDialog(context, documents, collections);
    }
  });
}

void _showBookListDialog(
    BuildContext context, List<DocumentSnapshot> documents, List<CollectionReference> collections) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppMainColor.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(25.w),
          ),
          width: 400.w,
          height: 700.h,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot document = documents[index];
              final data = document.data() as Map<String, dynamic>;
              String bookName = data.containsKey("bookName") ? data["bookName"] : "No Data";

              double bookPrice = data.containsKey("bookPrice") ? data["bookPrice"].toDouble() : 0.0;

              double bookRating = data.containsKey("bookRating")
                  ? data["bookRating"].toDouble()
                  : 0.0;
              String bookCategory = collections
                  .firstWhere(
                    (collection) => document.reference.path
                    .contains(collection.path.split('/').last),
              )
                  .id;

              String sell = documents[index]['Sell'];
              String swap = documents[index]['Swap'];
              String bookPicURL = documents[index]['bookPicURL'];
              String description = documents[index]['description'];
              String edition = documents[index]['edition'];
              String isbn_10 = documents[index]['isbn_10'];
              String isbn_13 = documents[index]['isbn_13'];
              String language = documents[index]['language'];
              String publisherName = documents[index]['publisherName'];
              String releaseDate = documents[index]['releaseDate'];
              String stock = documents[index]['stock'];
              String writerName = documents[index]['writerName'];
              String listerName = documents[index]['listerName'];
              String listerLocation = documents[index]['listerLocation'];
              String listerUID = documents[index]['listerUID'];
              String listerEmail = documents[index]['listerEmail'];
              RxList<RxBool> isLikedList = documents
                  .map((document) {
                bool initialValue = document['isLikedList'] ?? false;
                return RxBool(initialValue);
              })
                  .toList()
                  .obs;
              return Padding(
                padding: EdgeInsets.all(10.w),
                child: ListTile(
                  onTap: (){
                    Get.to(BookDetails(
                      listerUID: listerUID,
                      listerEmail: listerEmail,
                      listerName: listerName,
                      listerLocation: listerLocation,
                      sell: sell,
                      swap: swap,
                      bookPicURL: bookPicURL,
                      description: description,
                      edition: edition,
                      isbn_10: isbn_10,
                      isbn_13: isbn_13,
                      language: language,
                      publisherName: publisherName,
                      releaseDate: releaseDate,
                      stock: stock,
                      writerName: writerName,
                      bookPrice: bookPrice,
                      bookRating: bookRating,
                      bookName: bookName,
                      bookCategory: bookCategory,
                      wishlist: isLikedList[index].value,
                    ));
                  },
                  title: Text(
                    bookName.toString(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Text(
                    index.toString(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppMainColor.primaryColor,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: AppMainColor.primaryColor,
                thickness: 1,
              );
            },
          ),
        ),
      );
    },
  );
}

void _showNoBooksDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'No books are available',
          style: TextStyle(
            color: AppMainColor.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
