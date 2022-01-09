import 'package:ento/backend/models/Company.dart';
import 'package:ento/services/information.service.dart';
import 'package:ento/services/storage.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageNotifications extends StatefulWidget {
  final Company model;
  ManageNotifications({Key? key, required this.model}) : super(key: key);

  @override
  State<ManageNotifications> createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  final info = Get.find<InformationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.9), width: 0)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Text("manage ${widget.model.name} notifications"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: info.notificationTypes.length,
              itemBuilder: (context, index) {
                var item = info.notificationTypes.elementAt(index);
                var storedPermission =
                    storageService.getManagedPermission(widget.model.id);
                var value = storedPermission.permissions[item] ?? true;
                return SwitchListTile(
                  value: value,
                  onChanged: (value) {
                    storeage.setManagedPermission(widget.model.id, item, value);
                    setState(() {});
                  },
                  title: Text(item),
                  activeColor: Colors.orange,
                  // tileColor: Colors.red,
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
