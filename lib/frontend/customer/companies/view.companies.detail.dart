import 'package:ento/backend/models/Company.dart';
import 'package:ento/frontend/components/items/notification.item.dart';
import 'package:ento/frontend/components/items/notificationCustomer.item.dart';
import 'package:ento/frontend/components/manageNotifications.dart';
import 'package:ento/frontend/customer/companies/state.companies.details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompaniesDetailView extends StatelessWidget {
  final Company model;
  final bool subscribed;
  CompaniesDetailView({Key? key, required this.model, this.subscribed = false})
      : super(key: key);
  final controller = Get.put(CompanyDetailsState());

  @override
  Widget build(BuildContext context) {
    controller.getNotifications(model.id);
    return Scaffold(
      body: GetBuilder<CompanyDetailsState>(
        builder: (state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(model.name),
                actions: [
                  InkWell(
                    onTap: () {
                      controller.showQrCode(model);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: Icon(CupertinoIcons.qrcode),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (!subscribed)
                        controller.addCompany(model);
                      else
                        controller.removeCompany(model);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: Icon(
                        subscribed
                            ? CupertinoIcons.clear_circled
                            : CupertinoIcons.add_circled,
                      ),
                    ),
                  ),
                ],
              ),
              SliverAppBar(
                primary: false,
                expandedHeight: 400,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: AnimatedContainer(
                    // color: Colors.blue,
                    // height: controller.appBarHeight,
                    duration: Duration(milliseconds: 350),
                    child: Column(
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 350),
                          child: controller.isExpanded
                              ? Container(
                                  // padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Text(model.email),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Text(model.website ??
                                            "no website available"),
                                      ),
                                      ManageNotifications(model: model)
                                    ],
                                  ),
                                )
                              : Container(
                                  key: ValueKey("empty"),
                                ),
                        ),
                        Spacer(),
                        // TextButton(
                        //     onPressed: () {
                        //       controller.toggleHeight();
                        //     },
                        //     child: Text(
                        //       controller.isExpanded ? "less" : "more",
                        //       style:
                        //           TextStyle(color: Colors.white, fontSize: 18),
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
              if (controller.status.isSuccess)
                SliverList(
                    delegate: SliverChildListDelegate(controller.list.map((e) {
                  return NotificationCustomerItem(model: e);
                }).toList())),
              if (controller.status.isLoading)
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("loading"),
                  ),
                ),
              if (controller.status.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.red,
                    child: Text("empty"),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
