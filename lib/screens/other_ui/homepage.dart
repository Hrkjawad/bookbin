import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/main_appbar.dart';
import '../widgets/screen_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  String _greeting = '';
  @override
  void initState() {
    super.initState();
    _updateGreeting();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateGreeting();
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        _greeting = 'Good Morning';
      });
    } else if (hour < 17) {
      setState(() {
        _greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        _greeting = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(scaffoldKey, context),
      body: Scaffold(
        key: scaffoldKey,
        // drawer: NotificationEndDrawer(context),
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 33.h,
                  ),
                  Center(
                    child: Text(
                      'Hey, $_greeting!',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 296.w,
                        height: 48.h,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search Textbooks",
                            suffixIcon:  Icon(Icons.search, size: 25.w,),
                            hintStyle:  TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xff6B6B6B),
                            ),
                            contentPadding:  EdgeInsets.symmetric(
                              horizontal: 50.w,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                50.w,
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xff8847a1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.w,
                              ),
                              borderSide: const BorderSide(
                                color:  Color(0xff8847a1),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0XFFFFFFFF),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
