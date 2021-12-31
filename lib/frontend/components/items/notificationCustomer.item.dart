import 'package:ento/backend/models/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:ento/backend/extensions/ext.dart';

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
          Text(model.date.toString()).date(),
        ],
      ),
    );
  }
}
