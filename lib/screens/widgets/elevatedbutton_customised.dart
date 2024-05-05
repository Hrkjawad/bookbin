import 'package:flutter/material.dart';

class ElevatedButtonCustomised extends StatelessWidget {
  const ElevatedButtonCustomised({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
        onPressed: () {},
        child: const Text(
          "Create an Account",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
