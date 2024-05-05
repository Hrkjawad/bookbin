import 'package:BookBin/screens/widgets/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/textformfield_customized.dart';
import 'package:flutter/material.dart';

import '../widgets/elevatedbutton_customised.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            BackButtonAndLogo(),
            SizedBox(
              height: 52,
            ),
            Padding(
              padding: EdgeInsets.only(left: 31.0),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 54,
            ),
            TextFormFieldCustomized(),
            SizedBox(
              height: 30,
            ),
            TextFormFieldCustomized(),
            SizedBox(
              height: 30,
            ),
            TextFormFieldCustomized(),
            SizedBox(
              height: 30,
            ),
            TextFormFieldCustomized(),
            SizedBox(
              height: 30,
            ),
            TextFormFieldCustomized(),
            SizedBox(
              height: 54,
            ),
            Center(child: ElevatedButtonCustomised()),
                    ],
                  ),
          )),
    );
  }
}
