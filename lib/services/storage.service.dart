import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ento/backend/extensions/ext.dart';

class StorageService {
  late final GetStorage store;
  late final GetStorage notiStore;
  Future init() async {
    await GetStorage.init();
    store = GetStorage();
    notiStore = GetStorage("notiStore");
    return Future.value();
  }
}

StorageService storageService = StorageService();
StorageService get storeage => storageService;
