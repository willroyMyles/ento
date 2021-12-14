import 'package:ento/backend/api/api.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyDetailsState extends GetxController with StateMixin {
  final api = Get.find<ApiCall>();
  final info = Get.find<InformationService>();
  double appBarHeight = 50;
  bool isExpanded = false;

  @override
  void onInit() {
    super.onInit();
  }

  void getNotifications(String id) async {
    change("", status: RxStatus.loading());
    var res = await api.getNotifications(id);
    if (res != null) {
      if (res.length == 0) return change("", status: RxStatus.empty());
      change(res, status: RxStatus.success());
    } else {
      change("", status: RxStatus.error("could not get notifications"));
    }
  }

  toggleHeight() {
    appBarHeight = appBarHeight == 50 ? Get.height - 300 : 50;
    isExpanded = appBarHeight != 50;
    refresh();
  }
}
