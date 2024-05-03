import 'package:BookBin/application/assets_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(
        ImagesPath.mainLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
