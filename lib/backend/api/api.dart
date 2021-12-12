import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/network/networkCalls.dart';
import 'package:ento/services/information.service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ApiCall {
  final executor = Get.put(NetworkCalls());
  final info = Get.put(InformationService());
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
}
