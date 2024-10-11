// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationServices {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('logo');
//
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   static Future<void> showNotification(
//       {required int id, required String title, required String body}) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'chat_messages', // Channel ID
//       'Chat Messages', // Channel name
//       channelDescription: 'This channel is used for chat message notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: true,
//     );
//
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }
// }
