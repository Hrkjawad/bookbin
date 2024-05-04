import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:flutter/material.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Image.asset(
        ImagesPath.welcomeLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
