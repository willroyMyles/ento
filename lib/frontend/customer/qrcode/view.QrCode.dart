import 'package:ento/frontend/customer/qrcode/state.QrCode.dart';
import 'package:ento/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCode extends StatelessWidget {
  ScanQRCode({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final controller = Get.put(ScanQrCodeState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanQrCodeState>(builder: (_) {
        return Stack(
          children: [
            Container(
              child: QRView(
                key: qrKey,
                onQRViewCreated: controller.setBarcodeController,
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderWidth: 10,
                    // overlayColor: Colors.green.withOpacity(.2),
                    borderRadius: 5,
                    borderLength: 20),
              ),
            ),
            Positioned(
                bottom: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black.withOpacity(.3)),
                    child: Text(
                      "scan qr code".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                )),
            if (controller.showOverlay) Constants.loadingView
          ],
        );
      }),
    );
  }
}
