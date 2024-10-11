import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../utilitis/app_main_color.dart';
import '../other_ui/book_details.dart';

Future bottomSheetWishlist(BuildContext context) {
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
  List<Stream<QuerySnapshot>> streams = collections
      .map((collection) =>
          collection.where('isLikedList', isEqualTo: true).snapshots())
      .toList();

  Stream<List<QuerySnapshot>> combinedStream =
      CombineLatestStream.list(streams);
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent.withOpacity(0.8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
    ),
    builder: (context) => SizedBox(
        height: 500,
        child: StreamBuilder<List<QuerySnapshot>>(
            stream: combinedStream,
            builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something is wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // Convert the list of QuerySnapshots into a single list of DocumentSnapshots
              List<DocumentSnapshot> documents = snapshot.data!
                  .expand((querySnapshot) => querySnapshot.docs)
                  .toList();
              RxList<RxBool> isLikedList = documents
                  .map((document) {
                    bool initialValue = document['isLikedList'] ?? false;
                    return RxBool(initialValue);
                  })
                  .toList()
                  .obs;
              return Padding(
                padding: EdgeInsets.all(10.w),
                child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot document = documents[index];
                      final data = document.data() as Map<String, dynamic>;

                      String imageUrl = data.containsKey("bookPicURL")
                          ? data["bookPicURL"]
                          : "https://i.pinimg.com/736x/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.jpg";

                      String bookName = data.containsKey("bookName")
                          ? data["bookName"]
                          : "No Data";

                      double bookPrice = data.containsKey("bookPrice")
                          ? data["bookPrice"].toDouble()
                          : 0.0;
                      bool wishList = data.containsKey("isLikedList");
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
                      int stock = documents[index]['stock'];
                      String writerName = documents[index]['writerName'];
                      String listerName = documents[index]['listerName'];
                      String listerLocation = documents[index]['listerLocation'];
                      String listerUID = documents[index]['listerUID'];
                      String listerEmail = documents[index]['listerEmail'];
                      return ListTile(
                        onTap: () {
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
                            wishlist: wishList,
                          ));
                        },
                        leading: ClipOval(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text("${documents[index]["bookName"]}"),
                        subtitle: Text(
                          bookCategory,
                          style: TextStyle(
                            color: AppMainColor.primaryColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            isLikedList[index].toggle();
                            document.reference.update({
                              'isLikedList': isLikedList[index].value,
                            });
                          },
                          child: Obx(() => Icon(
                                Icons.favorite,
                                color: isLikedList[index].value
                                    ? Colors.red
                                    : Colors.grey,
                              )),
                        ),
                      );
                    }),
              );
            })),
  );
}
