import 'dart:io';

import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/models/CompanyLocation.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigureCompanyState extends GetxController
    with StateMixin, ApiInfoMixin {
  final name = TextEditingController();
  final email = TextEditingController();
  final website = TextEditingController();
  final contact = TextEditingController();
  File? logoFile;
  File? backdropFile;
  List<CompanyLocation> locations = [];

  onSubmit() async {
    Company company = Company.empty();
    company.name = name.text;
    company.email = email.text;
    company.website = website.text;
    company.contact = contact.text;
    company.logo = logoFile?.path ?? null;
    company.backdrop = backdropFile?.path ?? null;
    company.locations = locations;

    bool res = await api.createCompany(company);
    if (res) {
      Get.off(() => PastNotifications());
    }
  }
}
