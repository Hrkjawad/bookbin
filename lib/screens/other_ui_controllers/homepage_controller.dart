import 'dart:async';
import 'package:get/get.dart';

import '../../application/globals.dart ';

class HomeController extends GetxController {
  var greeting = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _updateGreeting();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateGreeting();
    });
    await fetchUserInfo();
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour == 0 && hour < 6) {
      greeting.value = 'Its Sleep Time';
    }
    else if (hour < 12) {
      greeting.value = 'Good Morning';
    }
    else if (hour < 17) {
      greeting.value = 'Good Afternoon';
    } else {
      greeting.value = 'Good Evening';
    }
  }
}
void deleteUID(){
  userUID ="";
}