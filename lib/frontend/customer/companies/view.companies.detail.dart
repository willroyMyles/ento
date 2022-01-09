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
        initState: (state) {
          controller.getExpanded(model.id);
        },
        builder: (state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(model.name),
                bottom: PreferredSize(
                  preferredSize: Size(0, 40),
                  child: Container(
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: Text(model.email),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          child: Text(model.website ?? "no website available"),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      var isSub = controller.info.userData.value.companyIds
                              ?.contains(model.id) ??
                          false;
                      if (!isSub)
                        controller.addCompany(model);
                      else
                        controller.removeCompany(model);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: Icon(
                        controller.info.userData.value.companyIds
                                    ?.contains(model.id) ??
                                false
                            ? CupertinoIcons.clear_circled
                            : CupertinoIcons.add_circled,
                      ),
                    ),
                  ),
                ],
              ),
              // if (controller.isExpanded)
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  constraints: BoxConstraints(
                      maxHeight: controller.isExpanded ? 250 : 0),
                  duration: Duration(milliseconds: 350),
                  child: Container(
                    // padding: EdgeInsets.all(15),
                    child: ManageNotifications(model: model),
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
