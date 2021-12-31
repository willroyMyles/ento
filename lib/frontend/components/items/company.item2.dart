import 'package:ento/backend/api/api.dart';
import 'package:ento/backend/models/Company.dart';
import 'package:ento/frontend/customer/companies/view.companies.detail.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyItem2 extends StatelessWidget {
  final Company model;
  final info = Get.find<InformationService>();
  final api = Get.find<ApiCall>();
  CompanyItem2({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CompaniesDetailView(
            model: model,
            subscribed:
                model.isCompanyInList(info.userData.value.companyIds ?? [])));
      },
      child: Container(
        height: 100,
        width: 240,
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name),
                SizedBox(
                  height: 5,
                ),
                Text(model.email)
              ],
            ),
            InkWell(
              onTap: () {
                var isSub =
                    model.isCompanyInList(info.userData.value.companyIds ?? []);
                if (isSub)
                  api.removeCompay(model);
                else
                  api.addCompay(model);
              },
              child: Container(
                child: Obx(
                  () => Icon(
                    CupertinoIcons.check_mark_circled,
                    size: 30,
                    color: model.isCompanyInList(
                            info.userData.value.companyIds ?? [])
                        ? Colors.green
                        : Colors.grey.withOpacity(.6),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
