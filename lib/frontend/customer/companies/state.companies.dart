import 'package:ento/backend/api/api.dart';
import 'package:ento/services/information.service.dart';
import 'package:get/get.dart';

class CompanyState extends GetxController with StateMixin {
  final api = Get.find<ApiCall>();
  final info = Get.find<InformationService>();

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  initialize() async {
    var res = await api.getCompanies();
    if (res) {
      if (info.companies.value.length == 0)
        return change("", status: RxStatus.empty());
      change("", status: RxStatus.success());
    } else
      change("", status: RxStatus.error("could not get companies"));
  }
}
