import 'dart:async';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var greeting = ''.obs;

  @override
onInit() {
    super.onInit();
    _updateGreeting();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateGreeting();
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 22 || hour < 6) {
      greeting.value = "It's Sleep Time";
    } else if (hour < 12) {
      greeting.value = 'Good Morning';
    } else if (hour < 17) {
      greeting.value = 'Good Afternoon';
    } else {
      greeting.value = 'Good Evening';
    }

  }
}