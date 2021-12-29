import 'dart:io';

import 'package:ento/backend/enums/formType.dart';
import 'package:ento/backend/models/DynamicFormModel.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFormState extends GetxController with StateMixin, ApiInfoMixin {
  List<DynamicFormModel> list = [];
  Map<DynamicFormModel, dynamic> conts = {};
  late String type;

  @override
  void onInit() {
    super.onInit();
  }

  void initialize(String type) async {
    this.type = type;
    conts.clear();
    change("", status: RxStatus.loading());
    refresh();
    var res = await api.getForm(type);
    for (var e in res) {
      if (e.type == FormType.TEXT)
        conts.putIfAbsent(e, () => TextEditingController());
      if (e.type == FormType.PICTURE) conts.putIfAbsent(e, () => "");
    }
    change(list, status: RxStatus.success());
  }

  submit() async {
    Map<String, dynamic> obj = {};
    obj.putIfAbsent("type", () => this.type);
    for (var item in conts.keys) {
      obj.putIfAbsent(item.key!, () => item.value);
    }

    var res = await api.createNotification(obj);
    if (res) {
      Get.showSnackbar(GetSnackBar(
        title: "Notification sent!",
        message: "your notifiation has been created",
        duration: Duration(milliseconds: 3000),
        margin: EdgeInsets.all(10),
      ));
      conts.values.forEach((element) {
        print(element.text);
        element.clear();
      });
      refresh();
    } else {
      Get.showSnackbar(GetSnackBar(
        title: "Notification not sent!",
        message: "your notifiation has not been created",
        duration: Duration(milliseconds: 3000),
      ));
    }
    print(obj);
  }

  void formAndStatus(
    String formType,
    Function? submit,
    Function? setSubmit,
  ) {
    initialize(formType);
    if (submit == null) submit = this.submit;
    if (setSubmit != null) setSubmit(this.submit);
  }
}
