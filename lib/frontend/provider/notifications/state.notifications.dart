import 'package:ento/backend/api/api.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/services/information.service.dart';
import 'package:ento/services/tags.service.dart';
import 'package:get/get.dart';

class PastNotificationState extends GetxController with StateMixin {
  List<NotificationModel> notifications = [];
  final ApiCall api = Get.find();
  final InformationService info = Get.find();

  NotificationModel model = NotificationModel.empty();

  String type = "select type";

  @override
  void onInit() {
    super.onInit();
  }

  initialize() async {
    info.notifications.stream.listen((event) {
      refresh();
      print("refrehsed");
    });

    bool ans = await api.getCompanyNotifications("id", 10);
  }

  void updatedType(String element) {
    type = element;
    refresh();
    api.getForm(element);
  }
}
