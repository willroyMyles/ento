import 'package:ento/frontend/customer/companies/view.companies.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:get/get.dart';

class LoginState extends GetxController with StateMixin {
  bool isCompany = false;

  onLogin() {
    if (!isCompany) {
      Get.to(() => CompaniesView());
    } else {
      Get.to(() => PastNotifications());
    }
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
