import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class C_page2 extends StatelessWidget {
  const C_page2 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard("Novels", Icons.menu_book_sharp),
        _buildSpacer(),
        _buildCard("Language", Icons.text_fields_outlined),
        _buildSpacer(),
        _buildCard("CSE", Icons.computer),
        _buildSpacer(),
        _buildCard("Education", Icons.school),
      ],
    );
  }
}

Widget _buildCard(String? name, IconData iconData) {
  return GestureDetector(
    onTap: () {
      //Get.to(() => const HomePage());
    },
    child: Column(
      children: [
        Card(
          color: const Color(0xff8847a1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  iconData,
                  size: 33.w,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Text(
          name ?? "No name",
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ],
    ),
  );
}


Widget _buildSpacer() {
  return SizedBox(width: 28.w);
}