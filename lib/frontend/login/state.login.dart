import 'package:ento/frontend/customer/companies/view.companies.dart';
import 'package:ento/frontend/provider/configure%20company/view.configureCompany.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginState extends GetxController with StateMixin, ApiInfoMixin {
  bool isCompany = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  onLogin() async {
    var res = await api.signInWithEmailAndPassword(
        email.text, password.text, isCompany);
    // if (res) {
    //   if (!isCompany) {
    //     Get.to(() => CompaniesView());
    //   } else {
    //     Get.to(() => PastNotifications());
    //   }
    // }
  }

  onRegister() async {
    var res = await api.signUpWithEmailAndPassword(
        email.text, password.text, isCompany);
    // if (res) {
    //   if (!isCompany) {
    //     Get.to(() => CompaniesView());
    //   } else {
    //     Get.to(() => ConfigureCompanyView());
    //   }
    // }
  }

  toggleIsCompany() {
    isCompany = !isCompany;
    refresh();
  }

  @override
  void onInit() {
    super.onInit();
    change("", status: RxStatus.success());
  }
}
