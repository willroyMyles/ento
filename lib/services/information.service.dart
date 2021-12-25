import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/backend/models/UserData.dart';
import 'package:get/get.dart';

class InformationService {
  RxObject<Company> companies = new RxObject({});
  RxObject<NotificationModel> notifications = new RxObject({});
  Rx<UserData> userData = UserData(id: "", email: "").obs;
  Rx<Company> myCompany = Company.empty().obs;
  RxList<String> notificationTypes = RxList([]);

  setUserData(UserData data) {
    userData.value = data;
    userData.refresh();
    print("user data refreshed $userData");
  }

  setMyCompany(Company company) {
    myCompany.value = company;
    myCompany.refresh();
  }

  setCompanies(List<dynamic> list) => companies.set(list);
  updateCompanies(Company model) => companies.updateModel(model);
  setNotifications(List<dynamic> list) => notifications.set(list);
  updateNotifications(Company model) => notifications.updateModel(model);
  setNotificationTypes(List<String> list) => notificationTypes.value = list;
  updateNotificationTypes(String type) => notificationTypes
    ..add(type)
    ..refresh();

  clearAll() {
    companies.clear();
    notifications.clear();
    userData.value = UserData(id: "", email: "");
    myCompany.value = Company.empty();
    notificationTypes.value = [];
    refreshAll();
  }

  refreshAll() {
    userData.refresh();
    myCompany.refresh();
    notificationTypes.refresh();
  }
}

class RxObject<T> extends Rx<Map<dynamic, T>> {
  RxObject(Map<dynamic, T> initial) : super(initial);

  set(List<dynamic> list) {
    this.value.clear();
    for (var item in list) {
      this.value.update(
            item.id,
            (value) => item,
            ifAbsent: () => item,
          );
    }
    this.announce();
  }

  void updateModel(dynamic model) {
    if (!this.value.containsKey(model.id)) {
      this.value.putIfAbsent(model.id, () => model);
    }
    this.announce();
  }

  clear() {
    this.value.clear();
    this.announce();
  }

  announce() => this.refresh();
}
