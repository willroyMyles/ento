import 'package:ento/backend/models/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ento/backend/extensions/ext.dart';

class NotificationDetailView extends StatelessWidget {
  final NotificationModel model;
  const NotificationDetailView({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text("Statistics"),
                pinned: true,
                toolbarHeight: 50,
                // bottom: ,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                StatTile(
                  title: "0 engaged",
                  subTitle: "amount of users who engaged your notification",
                ),
                StatTile(
                  title: "0 ignored",
                  subTitle: "amount of users who ignored your notification",
                ),
                StatTile(
                  title: "0 recieved",
                  subTitle: "amount of users who recieved your notification",
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("sent "),
                      Text(model.date!.toString()).dateExact()
                    ],
                  ),
                )
              ])),
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 350),
            bottom: 0,
            child: Container(
              height: 100,
              width: Get.width,
              color: Colors.grey.withOpacity(.3),
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title),
                  SizedBox(
                    height: 10,
                  ),
                  Text(model.body ?? ""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String title, subTitle;
  const StatTile({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }
}
