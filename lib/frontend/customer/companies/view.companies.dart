import 'package:ento/backend/api/api.dart';
import 'package:ento/frontend/components/items/company.item.dart';
import 'package:ento/frontend/customer/Drawer/view.drawer.dart';
import 'package:ento/frontend/customer/companies/state.companies.dart';
import 'package:ento/frontend/customer/qrcode/view.QrCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompaniesView extends StatelessWidget {
  CompaniesView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(CompanyState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            controller.api.getNotificationTypes();
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(.8),
                      offset: Offset(2, 3))
                ]),
            child: Icon(
              CupertinoIcons.add,
              size: 32,
            ),
          ),
          tooltip: "Add a company",
        ),
        drawer: Drawer(
          elevation: 0,
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
            Container(
              child: TextButton.icon(
                onPressed: () {
                  Get.to(() => ScanQRCode());
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                ),
                label: Text(""),
              ),
            ),
            Container(
              child: TextButton.icon(
                onPressed: () {
                  Get.to(() => ScanQRCode());
                },
                icon: Icon(
                  CupertinoIcons.qrcode_viewfinder,
                  color: Colors.white,
                ),
                label: Text(""),
              ),
            )
          ],
        ),
        body: GetBuilder<CompanyState>(
          init: controller,
          builder: (state) {
            List<dynamic> items =
                controller.info.companies.value.values.toList();

            if (controller.status.isSuccess) return success(items);

            if (controller.status.isLoading) {}

            return Container();
          },
        ));
  }

  Widget success(List<dynamic> items) {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CompanyItem(model: items.elementAt(index));
      },
    );
  }
}
