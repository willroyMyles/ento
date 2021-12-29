import 'package:ento/backend/models/Company.dart';
import 'package:ento/backend/network/baseCalls.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../extensions/ext.dart';

class NetworkCalls extends BaseCalls {
  Future<Response<dynamic>> getComapies() async {
    var res = await findAll(companyEndpoint);
    return res;
  }

  Future<Response<dynamic>> getNotifications(String id) async {
    var res = await dio.get("$baseUrl$companyEndpoint/$id$notificaionEndpoint");
    return res;
  }

  Future<Response<dynamic>> getUserNotifications(String id) async {
    var res = await dio.get("$baseUrl$userEndpoint/$id$notificaionEndpoint");
    return res;
  }

  getCompanyNotifications(String id, int offset) async {
    var res = await dio.get("$baseUrl$companyEndpoint/$id$notificaionEndpoint");
    return res;
  }

  getNotificationTypes() async {
    var res = await dio.get("$baseUrl$notificaionEndpoint/types");
    return res;
  }

  getForm(String id) async {
    var res = await findOne("$formsEndpoint", id);
    return res;
  }

  Future<Response<dynamic>> createNotification(Map<String, dynamic> obj) async {
    var res = await create("$notificaionEndpoint", obj);
    return res;
  }

  Future<Response<dynamic>> isUserPresent(User user) async {
    try {
      var res = await dio.get("$baseUrl$userEndpoint/exsist/${user.uid}");
      return res;
    } catch (e) {
      throw false;
    }
  }

  Future<Response<dynamic>> createUser(User user, bool isCompany) async {
    Map<String, dynamic> map = user.toLocalUserMap(val: isCompany);

    var res = await create("$userEndpoint", map);
    return res;
  }

  Future<Response<dynamic>> getUser(String userId) async {
    var res = await findOne("$userEndpoint", userId);
    return res;
  }

  createCompany(Company company, String id) async {
    var res = await create("$companyEndpoint/$id", company.toMap());
    return res;
  }

  addCompany(Company company, String id) async {
    var body = {
      "companyId": company.id,
      "userId": id,
      "token": "this token yah now"
    };
    var res = await dio.post("$baseUrl$userEndpoint/add", data: body);
    return res;
  }

  saveToken(String token, String id) async {
    var body = {"token": token, "userId": id};

    var res = await dio.post("$baseUrl$userEndpoint/add/token", data: body);
    return res;
  }

  addNotificationToMyNotifications(String userId, String ref) async {
    var res = await dio
        .post("$baseUrl$notificaionEndpoint/$userId/notifications/$ref");
    return res;
  }
}
