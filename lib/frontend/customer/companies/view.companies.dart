import 'package:ento/frontend/customer/Drawer/view.drawer.dart';
import 'package:ento/frontend/customer/qrcode/view.QrCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompaniesView extends StatelessWidget {
  CompaniesView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 10,
        child: DrawerView(),
      ),
      appBar: AppBar(
        title: Text("Companies"),
        leading: Container(
          child: TextButton.icon(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(
                CupertinoIcons.person_alt_circle_fill,
                color: Colors.white,
              ),
              label: Text("")),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                Get.to(() => ScanQRCode());
              },
              icon: Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
              label: Text("add"))
        ],
      ),
    );
  }
}
