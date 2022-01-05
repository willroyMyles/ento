import 'dart:io';

import 'package:ento/services/information.service.dart';
import 'package:ento/services/mixin.service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

mixin StorageMixin {
  final storage = FirebaseStorage.instance;

  Future<String> uploadPicture(String path, String companyId) async {
    try {
      var operation = storage.ref("company/$companyId/promotions");
      File file = File(path);
      var meta = SettableMetadata();
      var task = await operation.putFile(file);
      var url = await task.ref.getDownloadURL();
      return Future.value(url);
    } catch (e) {
      print(e);
      return Future.error("could not upload picture");
    }
  }

  Future<String> uploadPictureDynamic(
      String path, String storagePath, String companyId) async {
    try {
      var company = Get.find<InformationService>().myCompany.value;
      var operation =
          storage.ref("company/$storagePath/${company.name}-$companyId/image");
      File file = File(path);
      var meta = SettableMetadata();
      var task = await operation.putFile(file);
      var url = await task.ref.getDownloadURL();
      return Future.value(url);
    } catch (e) {
      print(e);
      return Future.error("could not upload picture");
    }
  }
}
