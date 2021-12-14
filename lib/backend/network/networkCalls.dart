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
}
