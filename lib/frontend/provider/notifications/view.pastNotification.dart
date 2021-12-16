import 'package:ento/frontend/provider/notifications/create/view.createNotification.dart';
import 'package:ento/frontend/provider/notifications/state.notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastNotifications extends StatelessWidget {
  PastNotifications({Key? key}) : super(key: key);
  final controller = Get.put(PastNotificationState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("company name"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateNotification());
        },
        child: Icon(CupertinoIcons.circle_grid_hex_fill),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Text("your past notifications here"),
        ),
      ),
    );
  }
}
