import 'package:ento/services/mixin.service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProviderSettingsState extends GetxController
    with StateMixin, ApiInfoMixin {
  void setBackdrop(String path) async {
    var obj = {"backdrop": path};
    bool res = await api.editCompany(obj);
  }

  void setLogo(String path) async {
    var obj = {"logo": path};
    bool res = await api.editCompany(obj);
  }
}
