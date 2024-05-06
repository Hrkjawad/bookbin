import 'package:BookBin/application/app_bookbin.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    SafeArea(
      child:
          DevicePreview(enabled: true, builder: (context) => const BookBin()),
    ),
  );
}
