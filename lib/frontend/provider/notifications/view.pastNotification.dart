import 'package:ento/frontend/components/items/notification.item.dart';
import 'package:ento/frontend/provider/drawer/view.drawer.dart';
import 'package:ento/frontend/provider/notifications/create/view.createNotification.dart';
import 'package:ento/frontend/provider/notifications/state.notifications.dart';
import 'package:ento/frontend/provider/settings/view.settings.dart';
import 'package:ento/services/constants.dart';
import 'package:ento/services/helper.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastNotifications extends StatelessWidget {
  PastNotifications({Key? key}) : super(key: key);
  final controller = Get.put(PastNotificationState());
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerViewProvider(),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(controller.info.myCompany.value.name)),
                Text(
                  "view all your notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            )),
        bottom: PreferredSize(
          preferredSize: Size(0, 20),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              )),
        ),
        actions: [
          InkWell(
            onTap: () {
              // controller.showQrCode(model);
              showQrCodeAnywhere(controller.info.myCompany.value);
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 15),
              child: Icon(CupertinoIcons.qrcode),
            ),
          ),
          Container(
            child: TextButton.icon(
                onPressed: () {
                  // _scaffoldKey.currentState?.openDrawer();
                  Get.to(() => ProviderSettingsView());
                },
                icon: Icon(
                  CupertinoIcons.settings,
                  color: Colors.white,
                ),
                label: Container()),
          ),
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
        child: GetBuilder<PastNotificationState>(builder: (state) {
          if (controller.status.isLoading)
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          if (controller.status.isEmpty)
            return Constants.empty("No Notifications \nas of yet");
          if (controller.status.isSuccess)
            return Container(
              alignment: Alignment.center,
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.callGetNotifications();
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    var item = controller.info.companyNotifications.value.values
                        .elementAt(index);
                    return NotificationItem(model: item);
                  },
                  itemCount:
                      controller.info.companyNotifications.value.values.length,
                ),
              ),
            );

          return Container(child: Text("somu"));
        }),
      ),
    );
  }
}
