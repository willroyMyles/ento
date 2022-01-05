import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/frontend/provider/notifications/detail/view.notificationDetail.dart';
import 'package:flutter/material.dart';
import 'package:ento/backend/extensions/ext.dart';
import 'package:get/get.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel model;
  const NotificationItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: InkWell(
        onTap: () {
          Get.to(() => NotificationDetailView(model: model));
        },
        child: Column(
          children: [
            if (model.picture != null)
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Image.network(model.picture!),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                SizedBox(
                  width: 10,
                ),
                Text(model.date.toString()).date(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
