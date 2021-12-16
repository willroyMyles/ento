import 'package:ento/backend/enums/formType.dart';
import 'package:ento/backend/models/DynamicFormModel.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFormState extends GetxController with StateMixin, ApiInfoMixin {
  List<DynamicFormModel> list = [];
  Map<DynamicFormModel, TextEditingController> conts = {};
  late String type;

  @override
  void onInit() {
    super.onInit();
  }

  CreateFormState(String type) {
    initialize(type);
    this.type = type;
  }

  void initialize(String type) async {
    var res = await api.getForm(type);
    for (var e in res) {
      if (e.type == FormType.TEXT)
        conts.putIfAbsent(e, () => TextEditingController());
    }
    change(list, status: RxStatus.success());
  }

  submit() {
    Map<String, dynamic> obj = {};
    obj.putIfAbsent("type", () => this.type);
    for (var item in conts.keys) {
      obj.putIfAbsent(item.key!, () => item.value);
    }

    api.createNotification(obj);
    print(obj);
  }
}
