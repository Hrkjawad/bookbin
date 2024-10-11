import '../auth_ui_controllers/forgotpass_controller.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/TextFields/textformfield_customized.dart';
import '../widgets/screen_background.dart';

class Verification extends StatefulWidget {
  const Verification({super.key, this.check});
  final bool? check;

  @override
  State<Verification> createState() => _SignupState();
}

class _SignupState extends State<Verification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _email.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonAndLogo(),
              SizedBox(
                height: 42.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 31.w),
                child: Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 31.w),
                child: Text(
                  "Enter your created account email address",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF595959),
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              TextFormFieldCustomized(
                controller: _email,
                hintText: "Enter your email address",
                icon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "Please fill this";
                  }
                  if (email.length < 5) {
                    return "Please enter a email address";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: ElevatedButtonCustomised(
                  onPressed: () => emailCheck(_formKey, _email, widget.check),
                  text: "Send",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
