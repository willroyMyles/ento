import 'package:ento/backend/network/baseCalls.dart';
import 'package:dio/dio.dart';

class NetworkCalls extends BaseCalls {
  Future<Response<dynamic>> getComapies() async {
    var res = await findAll(companyEndpoint);
    return res;
  }
}
