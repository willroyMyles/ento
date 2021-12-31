import 'package:ento/frontend/components/items/notification.item.dart';
import 'package:ento/frontend/components/items/notificationCustomer.item.dart';
import 'package:ento/frontend/customer/notifications/state.notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerNotificationView extends StatelessWidget {
  CustomerNotificationView({Key? key}) : super(key: key);
  final controller = Get.put(CustomerNotificationsState());

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: controller.obx((state) {
      return Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 15),
              child: Text("Notifications"),
            ),
            ...controller.info.notifications.value.values.map((e) {
              return NotificationCustomerItem(model: e);
            }).toList()
          ],
        ),
      );
    },
            onEmpty: Container(
              alignment: Alignment.center,
              child: Text("empty"),
            ),
            onError: (e) => Container(
                  child: Text("error"),
                ),
            onLoading: Container(
              child: Text("loading"),
            )));
  }
}
