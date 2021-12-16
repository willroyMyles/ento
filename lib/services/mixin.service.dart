import 'package:ento/backend/api/api.dart';
import 'package:ento/services/information.service.dart';
import 'package:get/get.dart';

mixin ApiInfoMixin {
  final api = Get.find<ApiCall>();
  final info = Get.find<InformationService>();
}
