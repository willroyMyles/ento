import 'package:ento/backend/models/Company.dart';
import 'package:get/get.dart';

class InformationService {
  RxObject<Company> companies = new RxObject({});

  setCompanies(List<dynamic> list) => companies.set(list);
  updateCompanies(Company model) => companies.updateModel(model);
}

class RxObject<T> extends Rx<Map<dynamic, dynamic>> {
  RxObject(Map initial) : super(initial);

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
