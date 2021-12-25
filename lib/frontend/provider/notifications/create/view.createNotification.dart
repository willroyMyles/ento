import 'package:ento/frontend/provider/notifications/create/view.createForm.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state.notifications.dart';

class CreateNotification extends StatelessWidget {
  CreateNotification({Key? key}) : super(key: key);
  final controller = Get.find<PastNotificationState>();
  final info = Get.find<InformationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: GetBuilder<PastNotificationState>(
          init: controller,
          builder: (state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showNotificaionType();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text(controller.type),
                  ),
                ),
                if (info.notificationTypes.contains(controller.type))
                  CreateFormView(formType: controller.type)
              ],
            );
          }),
    ));
  }

  showNotificaionType() {
    Get.bottomSheet(BottomSheet(
      enableDrag: false,
      builder: (context) {
        return Material(
          elevation: 5,
          color: Colors.white,
          child: Container(
            child: Wrap(
              children: info.notificationTypes
                  .map((element) => ListTile(
                        onTap: () {
                          controller.updatedType(element);
                          Get.close(1);
                        },
                        title: Text(element),
                      ))
                  .toList(),
            ),
          ),
        );
      },
      onClosing: () {},
    ));
  }
}
