import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCardCreate extends StatefulWidget {
  const BookCardCreate({super.key, required this.height});
  final double height;


  @override
  State<BookCardCreate> createState() => _BookCardCreateState();
}

class _BookCardCreateState extends State<BookCardCreate> {
  List<CardData> cardData = [
    CardData(
      imageUrl:
          'https://indobanglabook.s3.us-east-2.amazonaws.com/2109/71g2ednj0JL.jpeg',
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
      imageUrl:
          'https://indobanglabook.s3.us-east-2.amazonaws.com/2109/71g2ednj0JL.jpeg',
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
    return SizedBox(
      height: widget.height,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 260,
        ),
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          final item = cardData[index];
          return GestureDetector(
            onTap: () {
              // Get.back();
            },
            child: Column(
              children: [
                Stack(
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
                              "${item.bookPrice} ৳",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white),
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
                SizedBox(
                  width: 160.w,
                  height: 40.h,
                  child: SingleChildScrollView(
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

  }
}

class CardData {
  final String imageUrl;
  bool isLiked;
  final String bookPrice;
  final String rating;
  final String title;

  CardData({
    required this.imageUrl,
    required this.isLiked,
    required this.bookPrice,
    required this.rating,
    required this.title,
  });
}
