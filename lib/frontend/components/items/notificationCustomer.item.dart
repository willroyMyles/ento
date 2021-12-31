import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/frontend/customer/notifications/details/view.detail.dart';
import 'package:ento/services/bottomSheet.service.dart';
import 'package:flutter/material.dart';
import 'package:ento/backend/extensions/ext.dart';
import 'package:get/get.dart';

class NotificationCustomerItem extends StatelessWidget {
  final NotificationModel model;
  const NotificationCustomerItem({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: InkWell(
        onTap: () {
          // bts.showBottomSheet(NotificationCustomerDetail(model: model));
          bts.showNotificationBottomSheet(model);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.name != null) Text(model.name!),
                SizedBox(
                  height: 10,
                ),
                Text(model.title),
                SizedBox(
                  height: 4,
                ),
                Text(model.body ?? ""),
              ],
            ),
            Spacer(),
            if (model.picture != null)
              Icon(
                Icons.attach_file,
                color: Colors.grey.withOpacity(.7),
              ),
            Text(model.date.toString()).date(),
          ],
        ),
      ),
    );
  }
}
