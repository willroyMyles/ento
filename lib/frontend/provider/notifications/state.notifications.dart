import 'package:ento/backend/api/api.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/services/information.service.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:get/get.dart';

class PastNotificationState extends GetxController
    with StateMixin, ApiInfoMixin {
  List<NotificationModel> notifications = [];
  final ApiCall api = Get.find();
  final InformationService info = Get.find();
  RxInt int = 1.obs;

  NotificationModel model = NotificationModel.empty();

  String type = "select type";

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Function? submit;

  setSubmit(Function fun) {
    print("setted");
    submit = fun;
  }

  onSubmit() {
    submit!();
  }

  initialize() async {
    info.companyNotifications.stream.listen((event) {
      refresh();
      print("refrehsed");
      if (event.length == 0) return change("", status: RxStatus.empty());
      change("", status: RxStatus.success());
    });

    await api.getCompanyNotifications(offset: 0);
  }

  Future callGetNotifications() async {
    await api.getCompanyNotifications(offset: 0);
    return Future.value();
  }

  void updatedType(String element) {
    type = element;
    refresh();
    // api.getForm(element);
  }
}
