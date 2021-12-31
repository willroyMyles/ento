import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/frontend/customer/notifications/details/view.detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetService {
  showBottomSheet(Widget widget) {
    return Get.bottomSheet(DraggableScrollableSheet(
      initialChildSize: .7,
      maxChildSize: .7,
      minChildSize: .4,
      expand: true,
      snap: true,
      builder: (context, scrollController) {
        return widget;
      },
    ));
  }

  showNotificationBottomSheet(NotificationModel model) {
    return Get.bottomSheet(DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: .4,
      expand: true,
      snap: true,
      builder: (context, scrollController) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) => NotificationCustomerDetail(
            model: model,
            con: scrollController,
          ),
          // backgroundColor: Colors.green,
        );
      },
    ));
  }
}

BottomSheetService bottomSheetService = BottomSheetService();
BottomSheetService get bts => bottomSheetService;
