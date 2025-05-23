import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilitis/app_main_color.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField(
      {super.key, required this.hintText, required this.passwordController});

  final String hintText;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    bool isObscure = true;
    return Center(
      child: SizedBox(
        width: 350.w,
        child: StatefulBuilder(
          builder: (context, setState) {
            return TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: isObscure,
              controller: passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = ! isObscure;
                    });
                  },
                  icon: Icon(isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                ),
                hintStyle:  TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xff6B6B6B),
                ),
                contentPadding:  EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.w),
                  borderSide:  BorderSide(
                    color: AppMainColor.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.w),
                  borderSide:  BorderSide(
                    color: AppMainColor.primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.w),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    )
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.w),
                    borderSide: const BorderSide(
                        color: Colors.red
                    )
                ),
                filled: true,
                fillColor: const Color(0XFFFFFFFF),
                errorStyle:  TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              validator: (String? value) {
                if (value!.length < 8) {
                  return 'Password is too short and weak';
                }
                if (value != passwordController.text) {
                  return "Password didn't match";
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }
}