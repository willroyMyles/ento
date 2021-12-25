import 'package:ento/backend/models/NotificationModel.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.title),
              Text(DateTime.fromMillisecondsSinceEpoch(model.date!)
                  .toLocal()
                  .toString()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(model.body ?? ""),
        ],
      ),
    );
  }
}
