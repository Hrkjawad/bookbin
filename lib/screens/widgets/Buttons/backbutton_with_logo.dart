import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utilitis/assets_paths.dart';

class BackButtonAndLogo extends StatelessWidget {
  const BackButtonAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 30.h, left: 18.w),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon:  Icon(
              Icons.arrow_circle_left,
              color: const Color(0XFF8847A1),
              size: 36.sp,
            ),),
        ),
        const Spacer(),
        Padding(
          padding:  EdgeInsets.only(top: 30.h, left: 284.w),
          child: Image.asset(ImagesPath.mainLogo),
        )
      ],
    );
  }
}
