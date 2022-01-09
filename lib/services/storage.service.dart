import 'dart:convert';

import 'package:ento/backend/models/ManageNotificationModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ento/backend/extensions/ext.dart';

class StorageService {
  late final GetStorage store;
  late final GetStorage notiStore;
  late final GetStorage manageNotiStore;
  Future init() async {
    await GetStorage.init();
    store = GetStorage();
    notiStore = GetStorage("notiStore");
    manageNotiStore = GetStorage("manageNotiStore");
    return Future.value();
  }

  ManageNotificationModel getManagedPermission(String permissionId) {
    var obj = storeage.manageNotiStore.read(permissionId);
    var noti = ManageNotificationModel.fromMap(obj);
    return noti;
  }

  setManagedPermission(String permissionId, String permission, bool val) {
    var perm = getManagedPermission(permissionId);
    perm.permissions[permission] = val;
    manageNotiStore.write(permissionId, perm.toMap());
  }

  getDot(String id) {
    var value = notiStore.read(id);
    if (value == null) return false;
    return value;
  }

  setDot(String id) {
    var value = notiStore.read(id);
    if (value == null) notiStore.write(id, true);
  }
}

StorageService storageService = StorageService();
StorageService get storeage => storageService;
