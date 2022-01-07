import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/frontend/customer/notifications/details/view.detail.dart';
import 'package:ento/services/bottomSheet.service.dart';
import 'package:ento/services/storage.service.dart';
import 'package:flutter/material.dart';
import 'package:ento/backend/extensions/ext.dart';
import 'package:get/get.dart';

class NotificationCustomerItem extends StatefulWidget {
  final NotificationModel model;
  const NotificationCustomerItem({Key? key, required this.model})
      : super(key: key);

  @override
  State<NotificationCustomerItem> createState() =>
      _NotificationCustomerItemState();
}

class _NotificationCustomerItemState extends State<NotificationCustomerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: InkWell(
              onTap: () {
                // bts.showBottomSheet(NotificationCustomerDetail(model: model));
                bts.showNotificationBottomSheet(widget.model);
                storeage.notiStore.write(widget.model.id, false);
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * .7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.model.name != null) Text(widget.model.name!),
                        SizedBox(
                          height: 10,
                        ),
                        Text(widget.model.title),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.model.body ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  if (widget.model.picture != null)
                    Icon(
                      Icons.attach_file,
                      color: Colors.grey.withOpacity(.7),
                    ),
                  Text(widget.model.date.toString()).date(),
                ],
              ),
            ),
          ),
          if (storeage.getDot(widget.model.id))
            Positioned(
              top: 12,
              right: 22,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey.withOpacity(.1),
                          offset: Offset(0, 0))
                    ]),
              ),
            )
        ],
      ),
    );
  }
}
