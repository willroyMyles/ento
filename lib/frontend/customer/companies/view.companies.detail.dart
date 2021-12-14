import 'package:ento/backend/models/Company.dart';
import 'package:ento/frontend/components/manageNotifications.dart';
import 'package:ento/frontend/customer/companies/state.companies.dart';
import 'package:ento/frontend/customer/companies/state.companies.details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompaniesDetailView extends StatelessWidget {
  final Company model;
  CompaniesDetailView({Key? key, required this.model}) : super(key: key);
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
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 15),
                    child: Icon(CupertinoIcons.qrcode),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: AnimatedContainer(
                  color: Colors.blue,
                  height: controller.appBarHeight,
                  duration: Duration(milliseconds: 350),
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 350),
                        child: controller.isExpanded
                            ? Container(
                                child: Column(
                                  children: [
                                    Text(model.email),
                                    Text(model.website ??
                                        "no website available"),
                                    ManageNotifications(model: model)
                                  ],
                                ),
                              )
                            : Container(
                                key: ValueKey("empty"),
                              ),
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            controller.toggleHeight();
                          },
                          child: Text(
                            controller.isExpanded ? "less" : "more",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
              if (controller.status.isSuccess)
                SliverList(delegate: SliverChildListDelegate([Text("hello")])),
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
