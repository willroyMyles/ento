import 'package:ento/frontend/customer/drawer/view.drawer.dart';
import 'package:ento/frontend/customer/homepage/state.home.dart';
import 'package:ento/frontend/customer/notifications/view.notifications.dart';
import 'package:ento/frontend/customer/qrcode/view.QrCode.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final controller = Get.put(HomeState());
  final info = Get.find<InformationService>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // if (!info.userData.value.isCompany!)
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Companies"),
        leading: Container(
          child: TextButton.icon(
              onPressed: () {
                // _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(
                CupertinoIcons.person_alt_circle_fill,
                color: Colors.white,
              ),
              label: Text("")),
        ),
        actions: [
          Container(
            child: TextButton.icon(
              onPressed: () {
                Get.to(() => ScanQRCode());
              },
              icon: Icon(
                CupertinoIcons.search,
                color: Colors.white,
              ),
              label: Text(""),
            ),
          ),
          Container(
            child: TextButton.icon(
              onPressed: () {
                Get.to(() => ScanQRCode());
              },
              icon: Icon(
                CupertinoIcons.qrcode_viewfinder,
                color: Colors.white,
              ),
              label: Text(""),
            ),
          )
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        child: DrawerView(),
      ),
      // body: CustomScrollView(slivers: [CustomerNotificationView()]),
      body: PageView.builder(
          itemCount: controller.views.length,
          itemBuilder: (context, index) {
            return controller.views.elementAt(index);
          }),
    );

    // return PastNotifications();
  }
}
