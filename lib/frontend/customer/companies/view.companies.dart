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
        body: GetBuilder<CompanyState>(
      init: controller,
      builder: (state) {
        List<dynamic> items = controller.info.companies.value.values.toList();
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
