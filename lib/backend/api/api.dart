import 'dart:async';

import 'package:ento/backend/api/authMixin.dart';
import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/models/DynamicFormModel.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/backend/models/UserData.dart';
import 'package:ento/backend/network/networkCalls.dart';
import 'package:ento/frontend/customer/homepage/view.home.dart';
import 'package:ento/frontend/login/view.login.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:ento/services/information.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ApiCall with AuthMixin {
  //consider moving executor off get management
  final executor = Get.put(NetworkCalls());
  final info = Get.put(
    InformationService(),
  );
  var registering = false;

  ApiCall() {
    getNotificationTypes();
    this.auth.authStateChanges().listen((event) async {
      try {
        if (event != null && !registering) {
          print("user signed in");

          var u = await getLocalUser(event);
          info.setUserData(u);
          if (u.company != null) {
            info.setMyCompany(u.company!);
          }
          if (u.isCompany ?? true) {
            Get.off(() => PastNotifications());
          } else {
            Get.off(() => HomeView());
          }
        } else {
          print("user signed out");
          Get.off(() => LoginView());
        }
      } catch (e) {}
    });
  }

  alreadyCreated(User user) {
    try {} catch (e) {
      // createLocalUser(user, isCompany)
    }
  }

  Future<bool> signInWithEmailAndPassword(
      String email, String password, bool isCompany) async {
    try {
      password = password.trim();
      registering = false;
      var res = await authSignInWithEmailAndPassword(email, password);
      if (res != null) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      String email, String password, bool isCompany) async {
    try {
      password = password.trim();
      registering = true;

      var res = await authSignUpWithEmailAndPassword(email, password);
      this.createLocalUser(res.user!, isCompany);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  createLocalUser(User user, bool isCompany) async {
    try {
      var res = await executor.createUser(user, isCompany);
      var userData = UserData.fromMap(res.data);
      info.setUserData(userData);
      if (userData.company != null) {
        info.setMyCompany(userData.company!);
      }
    } on DioError catch (e) {
      print(e);
    } on Error catch (e) {
      print(e);
    }
  }

  Future<UserData> getLocalUser(User user) async {
    try {
      var res = await executor.getUser(user);
      var userData = UserData.fromMap(res.data);
      info.setUserData(userData);
      return Future.value(userData);
    } on DioError catch (e) {
      print(e);
      return Future.error("error");
    } on Error catch (e) {
      print(e);
      return Future.error("error");
    }
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

  getCompanyNotifications({int offset = 0, String? id = ""}) async {
    try {
      if (id == "") id = info.myCompany.value.id;
      var res = await executor.getNotifications(id!);
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
      obj["companyId"] = info.myCompany.value.id;
      await executor.createNotification(obj);
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

  Future<bool> createCompany(Company company) async {
    try {
      var res = await executor.createCompany(company, info.userData.value.id);
      var company1 = Company.fromMap(res.data);
      info.setMyCompany(company1);
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }

  Future<bool> addCompay(Company model) async {
    try {
      await executor.addCompany(model, info.userData.value.id);
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("could not subscribe company");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("could not subscribe company");
    }
  }

  saveToken(String? token) async {
    try {
      if (token == null) return;
      await executor.saveToken(token, info.userData.value.id);
      print("token saved");
    } catch (e) {
      print(e);
      print("could not save token");
    }
  }

  void addNotificationToMyNotifications(String? ref) async {
    if (ref == null) return;
    try {
      var res = await executor.addNotificationToMyNotifications(
          info.userData.value.id, ref);
    } on DioError catch (e) {
      printError(info: e.toString());
      // return Future.error("could not subscribe company");
    } on Error catch (e) {
      printError(info: e.toString());
      // return Future.error("could not subscribe company");
    }
  }
}
