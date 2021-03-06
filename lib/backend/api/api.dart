import 'dart:async';

import 'package:ento/backend/api/authMixin.dart';
import 'package:ento/backend/api/storageMixin.dart';
import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/models/DynamicFormModel.dart';
import 'package:ento/backend/models/NotificationModel.dart';
import 'package:ento/backend/models/UserData.dart';
import 'package:ento/backend/network/networkCalls.dart';
import 'package:ento/frontend/customer/homepage/view.home.dart';
import 'package:ento/frontend/login/view.login.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:ento/services/information.service.dart';
import 'package:ento/services/storage.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ApiCall with AuthMixin, StorageMixin {
  //consider moving executor off get management
  final executor = Get.put(NetworkCalls());
  final info = Get.put(
    InformationService(),
  );
  var registering = false;

  ApiCall() {
    getNotificationTypes();
    getUserFromStorage();
    // this.auth.authStateChanges().listen((event) async {
    //   try {
    //     if (event != null) {
    //       print("user signed in");

    //       // var u = await getLocalUser(event);
    //       // info.setUserData(u);
    //       // if (u.company != null) {
    //       //   info.setMyCompany(u.company!);
    //       // }
    //       // if (u.isCompany ?? true) {
    //       //   Get.off(() => PastNotifications());
    //       // } else {
    //       //   Get.off(() => HomeView());
    //       // }
    //     } else {
    //       print("user signed out");
    //       // info.setUserData(null);
    //       // Get.off(() => LoginView());
    //     }
    //   } catch (e) {}
    // });
  }

  getUserFromStorage() async {
    try {
      var userId = storeage.store.read("userId");

      if (userId == null) {
        print("no user found in storage");
        info.setUserData(null);
        return;
      }

      await getLocalUser(userId);
    } catch (e) {
      print("error in getUserFromStorage $e");
      // storeage.store.remove("uid");
      info.setUserData(null);
    }
  }

  Future<bool> signInWithEmailAndPassword(
      String email, String password, bool isCompany) async {
    try {
      password = password.trim();
      registering = false;
      var res = await authSignInWithEmailAndPassword(email, password);
      if (res != null) {
        var data = UserData.fromMap(res);
        info.setUserData(data);
        storeage.store.write("userId", data.id);
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

      var res = await authSignUpWithEmailAndPassword(email, password,
          isCompany: isCompany);
      var data = UserData.fromMap(res);
      info.setUserData(data);
      storeage.store.write("userId", data.id);
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

  Future<UserData> getLocalUser(String userId) async {
    try {
      var res = await executor.getUser(userId);
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
      info.setCompanyNotifications(list);
      return Future.value(list);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("no list");
    }
  }

  Future<List<NotificationModel>> getUserNotifications() async {
    try {
      var res = await executor.getUserNotifications(info.userData.value.id);
      var list = transformNotifications(res.data["notifications"]);
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

  transformNotifications(dynamic data) {
    List<NotificationModel> list = [];
    for (var item in data) {
      var n = NotificationModel.fromMap(item);
      list.add(n);
      storeage.setDot(n.id);
    }

    return list;
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
      info.setCompanyNotifications(list);
      return Future.value(list);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.value([]);
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.value([]);
    }
  }

  Future<bool> createNotification(Map<String, dynamic> obj) async {
    try {
      obj["companyId"] = info.myCompany.value.id;
      String? picture;
      if (obj.containsKey("picture")) {
        picture = await uploadPictureToBucket(obj["picture"]);
        obj["picture"] = picture;
      }
      var res = await executor.createNotification(obj);
      NotificationModel model = NotificationModel.fromMap(res.data);
      info.updateCompanyNotifications(model);
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.value(false);
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.value(false);
    }
  }

  Future<String?> uploadPictureToBucket(String? path) {
    if (path == null) return Future.value(null);
    try {
      return uploadPicture(path, info.userData.value.company!.id);
    } catch (e) {
      print(e);
      return Future.error("could not upload picture");
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

  Future<bool> addCompay(String ref) async {
    try {
      if (info.userData.value.companyIds!.contains(ref)) {
        //promt that user already added company
        print("ref is already in ids");
        return Future.value(true);
      }
      await executor.addCompany(ref, info.userData.value.id);
      info.userData.value.companyIds?.add(ref);
      info.userData.refresh();
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
      NotificationModel model = NotificationModel.fromMap(res.data);
      info.updateNotifications(model);
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      // return Future.error("could not subscribe company");
    } on Error catch (e) {
      printError(info: e.toString());
      // return Future.error("could not subscribe company");
    }
  }

  removeCompay(Company model) async {
    try {
      // await executor.removeCompany(model, info.userData.value.id);
      info.userData.value.companyIds?.remove(model.id);
      info.userData.refresh();
      return Future.value(true);
    } on DioError catch (e) {
      printError(info: e.toString());
      return Future.error("could not subscribe company");
    } on Error catch (e) {
      printError(info: e.toString());
      return Future.error("could not subscribe company");
    }
  }

  Future<bool> editCompany(Map<String, dynamic> obj) async {
    try {
      final id = info.myCompany.value.id;
      if (obj.containsKey("backdrop"))
        obj["backdrop"] =
            await uploadPictureDynamic(obj["backdrop"], "backdrop", id);
      if (obj.containsKey("logo"))
        obj["logo"] = await uploadPictureDynamic(obj["logo"], "logo", id);
      var res = await executor.editCompany(obj, id);
      Company c = Company.fromMap(res.data);
      info.setMyCompany(c);

      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }
}
