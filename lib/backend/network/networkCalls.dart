import 'package:ento/backend/network/baseCalls.dart';
import 'package:dio/dio.dart';

class NetworkCalls extends BaseCalls {
  Future<Response<dynamic>> getComapies() async {
    var res = await findAll(companyEndpoint);
    return res;
  }

  Future<Response<dynamic>> getNotifications(String id) async {
    var res = await dio.get("$baseUrl$companyEndpoint/$id$notificaionEndpoint");
    return res;
  }

  getNotificationTypes() async {
    var res = await dio.get("$baseUrl$notificaionEndpoint/types");
    return res;
  }

  getCompanyNotifications(String id, int offset) async {
    var res = await dio.get("$baseUrl$companyEndpoint/$id$notificaionEndpoint");
    return res;
  }

  getForm(String id) async {
    var res = await findOne("$formsEndpoint", id);
    return res;
  }

  createNotification(Map<String, dynamic> obj) async {
    var res = await create("$notificaionEndpoint", obj);
    return res;
  }
}
