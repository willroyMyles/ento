import 'package:ento/backend/models/Company.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';

class ShowQrCode extends StatelessWidget {
  final Company model;
  const ShowQrCode({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.width,
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(model.name),
            ),
            SizedBox(
              height: 25,
            ),
            QrImage(
              data: model.toQrJson(),
              size: Get.width - 150,
              gapless: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.green,
              dataModuleStyle: QrDataModuleStyle(
                  color: Colors.green,
                  dataModuleShape: QrDataModuleShape.circle),
              eyeStyle:
                  QrEyeStyle(color: Colors.green, eyeShape: QrEyeShape.circle),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Text("ENTO"),
            ),
          ],
        ));
  }
}
