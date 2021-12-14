import 'package:ento/backend/models/Company.dart';
import 'package:ento/frontend/customer/companies/view.companies.detail.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageNotifications extends StatelessWidget {
  final Company model;
  ManageNotifications({Key? key, required this.model}) : super(key: key);
  final info = Get.find<InformationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.2), width: 2)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text("manage ${model.name} notifications"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: info.notificationTypes.length,
              itemBuilder: (context, index) {
                var item = info.notificationTypes.elementAt(index);
                return SwitchListTile(
                  value: true,
                  onChanged: (value) {},
                  title: Text(item),
                  activeColor: Colors.orange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ManageNotificationState extends GetxController {}
