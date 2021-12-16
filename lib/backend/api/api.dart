import 'dart:async';

import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/models/DynamicFormModel.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/backend/network/networkCalls.dart';
import 'package:ento/frontend/provider/notifications/create/view.createNotification.dart';
import 'package:ento/services/information.service.dart';
import 'package:ento/services/tags.service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ApiCall {
  //consider moving executor off get management
  final executor = Get.put(NetworkCalls());
  final info = Get.put(
    InformationService(),
  );

  ApiCall() {
    getNotificationTypes();
  }

  Future<bool> getCompanies() async {
    try {
      var res = await executor.getComapies();
      List<Company> list = [];

      for (var data in res.data) {
        var p = Company.fromMap(data);
        list.add(p);
      }
      info.setCompanies(list);
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.value(false);
    } on Exception catch (e) {
      printError(info: e.toString());
      return Future.value(false);
    }
  }

  Future<List<NotificationModel>> getNotifications(String id) async {
    try {
      var res = await executor.getNotifications(id);
      List<NotificationModel> list = [];
      for (var item in res.data) {
        var n = NotificationModel.fromMap(item);
        list.add(n);
      }
      info.setNotifications(list);
      return Future.value(list);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }

  FutureOr<void> getNotificationTypes() async {
    try {
      var res = await executor.getNotificationTypes();
      List<String> list = (res.data as List<dynamic>).cast<String>();
      info.setNotificationTypes(list);
      return Future.value(null);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }

  getCompanyNotifications(String id, int offset) async {
    try {
      var res = await executor.getNotifications(id);
      List<NotificationModel> list = [];
      for (var item in res.data) {
        var n = NotificationModel.fromMap(item);
        list.add(n);
      }
      info.setNotifications(list);
      return Future.value(list);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }

  Future<bool> createNotification(Map<String, dynamic> obj) async {
    try {
      var res = executor.createNotification(obj);
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }

  Future<List<DynamicFormModel>> getForm(String id) async {
    try {
      var res = await executor.getForm(id);
      List<DynamicFormModel> list = [];
      for (var item in res.data) {
        var dfi = DynamicFormModel.fromMap(item);
        list.add(dfi);
      }
      return Future.value(list);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }
}
