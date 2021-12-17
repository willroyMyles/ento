import 'dart:io';

import 'package:ento/frontend/provider/configure%20company/state.configureCompany.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigureCompanyView extends StatelessWidget {
  ConfigureCompanyView({Key? key}) : super(key: key);
  final controller = Get.put(ConfigureCompanyState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              child: Text("ENTO"),
            ),
          ),
          Positioned(
              top: 150,
              child: Container(
                height: Get.height * .7,
                width: Get.width - 30,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(25),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Company Registration")),
                      Container(
                          child: TextFormField(
                        controller: controller.name,
                        decoration: InputDecoration(label: Text("name")),
                      )),
                      Container(
                          child: TextFormField(
                        controller: controller.email,
                        decoration: InputDecoration(label: Text("email")),
                      )),
                      Container(
                          child: TextFormField(
                        controller: controller.website,
                        decoration: InputDecoration(label: Text("website")),
                      )),
                      Container(
                          child: TextFormField(
                        controller: controller.contact,
                        decoration:
                            InputDecoration(label: Text("contact number")),
                      )),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                margin: EdgeInsets.only(right: 5, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("logo"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 5, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 100,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("backdrop"),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Material(
                        child: ListTile(
                          onTap: () {},
                          leading: Icon(CupertinoIcons.add_circled),
                          title: Text("Add Location"),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 20,
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: TextButton(
                  child: Text("submit"),
                  onPressed: () {
                    controller.onSubmit();
                  },
                ),
              ))
        ],
      ),
    );
  }
}
