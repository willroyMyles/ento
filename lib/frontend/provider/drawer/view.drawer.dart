import 'package:ento/frontend/login/view.login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerViewProvider extends StatelessWidget {
  const DrawerViewProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Get.statusBarHeight, left: 10, bottom: 20),
      padding: EdgeInsets.all(25),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              "ENTO",
              style: TextStyle(fontSize: 35),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.search),
            title: Text("Search"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.settings_solid),
            title: Text("Settings"),
            onTap: () {},
          ),
          Spacer(
            flex: 12,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.escape),
            title: Text("Log out"),
            onTap: () {
              Get.off(() => LoginView());
            },
          )
        ],
      ),
    );
  }
}
