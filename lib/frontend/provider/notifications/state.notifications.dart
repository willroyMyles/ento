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

  NotificationModel model = NotificationModel.empty();

  String type = "select type";

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  initialize() async {
    info.notifications.stream.listen((event) {
      refresh();
      print("refrehsed");
      change("", status: RxStatus.success());
    });

    await api.getCompanyNotifications(offset: 0);
  }

  void updatedType(String element) {
    type = element;
    refresh();
    api.getForm(element);
  }
}
