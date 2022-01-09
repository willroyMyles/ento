import 'dart:async';
import 'dart:convert';

import 'package:ento/services/mixin.service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeState extends GetxController with ApiInfoMixin {
  late Timer t;
  late QRViewController con;
  bool showOverlay = false;
  bool scanned = false;

  @override
  void onInit() {
    super.onInit();
    t = Timer(Duration(seconds: 120), () {
      Get.back();
    });
  }

  @override
  void onClose() {
    super.onClose();
    t.cancel();
  }

  setBarcodeController(QRViewController p0) {
    con = p0;
    con.scannedDataStream.listen((event) {
      if (!scanned) handleScannedBarcode(event);
    });
  }

  handleScannedBarcode(Barcode barcode) async {
    scanned = true;
    await con.pauseCamera();
    // await con.stopCamera();
    showOverlay = true;
    refresh();
    var map = jsonDecode(barcode.code!) as Map<String, dynamic>;
    print(map);
    //api call here
    await api.addCompay(map["id"]);
    // await showPopoup here that company has been added
    // Get.back();
    showOverlay = false;
    await con.resumeCamera();
    refresh();
  }
}
