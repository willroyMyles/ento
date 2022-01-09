import 'package:ento/backend/api/api.dart';
import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/frontend/components/showQRCode.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyDetailsState extends GetxController with StateMixin {
  final api = Get.find<ApiCall>();
  final info = Get.find<InformationService>();
  double appBarHeight = 50;
  bool isExpanded = true;
  List<NotificationModel> list = [];
  @override
  void onInit() {
    super.onInit();
  }

  bool getExpanded(String id) {
    isExpanded = info.userData.value.companyIds?.contains(id) ?? false;
    return isExpanded;
  }

  void getNotifications(String id) async {
    change("", status: RxStatus.loading());
    var res = await api.getNotifications(id);
    if (res != null) {
      list = res;
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

  showQrCode(Company model) {
    Get.dialog(
        AlertDialog(
          content: ShowQrCode(model: model),
        ),
        barrierColor: Colors.grey.withOpacity(.3));
  }

  void addCompany(Company model) async {
    await api.addCompay(model.id);
    getExpanded(model.id);
    refresh();
  }

  void removeCompany(Company model) async {
    await api.removeCompay(model);
    getExpanded(model.id);
    refresh();
  }
}
