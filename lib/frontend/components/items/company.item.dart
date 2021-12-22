import 'package:ento/backend/models/Company.dart';
import 'package:ento/frontend/customer/companies/view.companies.detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyItem extends StatelessWidget {
  final Company model;
  const CompanyItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CompaniesDetailView(model: model));
      },
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [Text(model.name), Text(model.email)],
        ),
      ),
    );
  }
}
