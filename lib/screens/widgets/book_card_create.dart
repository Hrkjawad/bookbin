import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui/homepage.dart';

class BookCardCreate extends StatefulWidget {
  const BookCardCreate({super.key});

  @override
  State<BookCardCreate> createState() => _BookCardCreateState();
}

class _BookCardCreateState extends State<BookCardCreate> {
  List<CardData> cardData = [
    CardData(
      imageUrl: 'https://indobanglabook.s3.us-east-2.amazonaws.com/2109/71g2ednj0JL.jpeg',
      isLiked: false,
      bookPrice: '100',
      rating: '4.0',
      title: 'Psychology of Money Book',
    ),
    CardData(
      imageUrl: 'https://m.media-amazon.com/images/I/61NP3Oa+TSL._SL500_.jpg',
      isLiked: true,
      bookPrice: '150',
      rating: '4.5',
      title: 'Harry Potter the Goblet of Fire',
    ),
    CardData(
      imageUrl: 'https://indobanglabook.s3.us-east-2.amazonaws.com/2109/71g2ednj0JL.jpeg',
      isLiked: false,
      bookPrice: '100',
      rating: '4.0',
      title: 'Psychology of Money Book',
    ),
    CardData(
      imageUrl: 'https://m.media-amazon.com/images/I/61NP3Oa+TSL._SL500_.jpg',
      isLiked: true,
      bookPrice: '150',
      rating: '4.5',
      title: 'Harry Potter the Goblet of Fire',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final item in cardData)
            GestureDetector(
              onTap: (){
                //Get.back();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.w),
                            child: Image.network(
                              item.imageUrl,
                              width: 166.w,
                              height: 217.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12.w,
                          top: 8.h,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                item.isLiked = !item.isLiked;
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color: item.isLiked ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 10.w,
                          child: SizedBox(
                            width: 65.w,
                            height: 28.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Center(
                                child: Text(
                                  "৳ ${item.bookPrice}",
                                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          right: 11.w,
                          child: SizedBox(
                            width: 45.w,
                            height: 26.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.rating,
                                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 160.w,
                    height: 40.h,
                    child: SingleChildScrollView(
                      child: Text(
                        textAlign: TextAlign.center,
                        item.title,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp, ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }
}
