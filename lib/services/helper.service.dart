import 'package:ento/backend/models/Company.dart';
import 'package:ento/frontend/components/showQRCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showQrCodeAnywhere(Company model) {
  Get.dialog(
      AlertDialog(
        content: ShowQrCode(model: model),
      ),
      barrierColor: Colors.grey.withOpacity(.3));
}
