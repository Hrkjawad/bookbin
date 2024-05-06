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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
