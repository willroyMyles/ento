import 'package:ento/frontend/provider/drawer/view.drawer.dart';
import 'package:ento/frontend/provider/notifications/create/view.createNotification.dart';
import 'package:ento/frontend/provider/notifications/state.notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastNotifications extends StatelessWidget {
  PastNotifications({Key? key}) : super(key: key);
  final controller = Get.put(PastNotificationState());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerViewProvider(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => Text(controller.info.myCompany.value.name)),
        actions: [
          Container(
            child: TextButton.icon(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(
                  CupertinoIcons.settings,
                  color: Colors.white,
                ),
                label: Container()),
          )
        ],
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
