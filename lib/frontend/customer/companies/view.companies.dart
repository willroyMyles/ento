import 'package:ento/frontend/components/items/company.item.dart';
import 'package:ento/frontend/components/items/company.item2.dart';
import 'package:ento/frontend/customer/companies/state.companies.dart';
import 'package:ento/frontend/customer/companies/view.allCompanies.dart';
import 'package:ento/services/fbMessaging.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompaniesView extends StatelessWidget {
  CompaniesView({Key? key}) : super(key: key);
  final controller = Get.put(CompanyState());
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 2,
      collapsedHeight: 3,
      expandedHeight: 211,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            child: GetBuilder<CompanyState>(
          init: controller,
          builder: (state) {
            List<dynamic> items =
                controller.info.companies.value.values.toList();
            if (controller.status.isSuccess) return success(items);
            if (controller.status.isLoading) {}
            return Container();
          },
        )),
      ),
    );
  }

  Widget success(List<dynamic> items) {
    return Container(
      height: 210,
      width: Get.width,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Companies")),
                TextButton(
                    onPressed: () {
                      Get.to(() => AllCompaniesView());
                    },
                    child: Text("view all"))
              ],
            ),
          ),
          Container(
            height: 160,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(.15)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(15),
              itemCount: items.length < 5 ? items.length : 5,
              itemBuilder: (context, index) {
                return CompanyItem2(model: items.elementAt(index));
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: TextButton(
          //     onPressed: () {
          //       // noti.createNotification();
          //       messagingService.justPrint();
          //     },
          //     child: Text("hello"),
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all(Colors.black)),
          //   ),
          // )
        ],
      ),
    );
  }
}
