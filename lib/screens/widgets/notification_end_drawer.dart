import 'package:flutter/material.dart';

class NotificationEndDrawer extends StatelessWidget {
  const NotificationEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7, // Adjust the height as needed
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: const Text('Swap Request Chat'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: const Text('One Book Sell Request'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
    );
  }
}