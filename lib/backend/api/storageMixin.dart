import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

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
}
