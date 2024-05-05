import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilitis/assets_paths.dart';

class BackButtonAndLogo extends StatelessWidget {
  const BackButtonAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 18),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_circle_left,
              color: Color(0XFFA158AD),
              size: 36,
            ),),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 284),
          child: Image.asset(ImagesPath.mainLogo),
        )
      ],
    );
  }
}
