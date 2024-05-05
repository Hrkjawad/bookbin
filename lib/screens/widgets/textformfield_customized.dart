import 'package:flutter/material.dart';

class TextFormFieldCustomized extends StatelessWidget {
  const TextFormFieldCustomized({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 51,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Enter your full name",
            hintStyle: const TextStyle(
              fontSize: 20,
              color: Color(0xff6B6B6B),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            filled: true,
            fillColor: const Color(0XFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
