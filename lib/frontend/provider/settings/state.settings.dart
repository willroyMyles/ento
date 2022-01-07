import 'package:ento/services/mixin.service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProviderSettingsState extends GetxController
    with StateMixin, ApiInfoMixin {
  void setBackdrop(String path) => setObject(path, "backdrop");
  void setLogo(String path) => setObject(path, "logo");
  void setName(String path) => setObject(path, "name");
  void setWebsite(String path) => setObject(path, "website");
  void setPhoneNumber(String path) => setObject(path, "contact");

  void setObject(String prop, String propName) async {
    var obj = {propName: prop};
    bool res = await api.editCompany(obj);
    refresh();
  }
}
