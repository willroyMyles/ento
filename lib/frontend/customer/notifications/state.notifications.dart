import 'package:ento/backend/api/api.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomerNotificationsState extends GetxController
    with StateMixin, ApiInfoMixin {
  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  void getNotifications() async {
    info.notifications.stream.listen((event) {
      if (info.notifications.value.isEmpty)
        return change([], status: RxStatus.empty());
      change(info.notifications.value.values, status: RxStatus.success());
    });

    await api.getUserNotifications();
  }
}
