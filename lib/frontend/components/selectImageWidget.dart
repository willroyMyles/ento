import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';

class SelectImageWidget extends StatefulWidget {
  final Size? size;
  final String msg;
  final String? imageUrl;
  final ValueSetter<String> valueSetter;
  SelectImageWidget(
      {Key? key,
      this.size = const Size(200, 150),
      required this.msg,
      this.imageUrl,
      required this.valueSetter})
      : super(key: key);

  @override
  _SelectImageWidgetState createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  String? path;
  final model = Get.find<InformationService>().myCompany.value;

  selectImage() async {
    try {
      List<Media>? res = await ImagesPicker.pick(
          count: 1,
          maxSize: 500,
          quality: .8,
          language: Language.English,
          pickType: PickType.image);
      if (res != null) {
        var media = res.first;
        setState(() {
          path = media.path;
        });
        widget.valueSetter(path!);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectImage();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        width: widget.size!.width,
        height: widget.size!.height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl ?? "",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)));
                  },
                  errorWidget: (context, url, error) => path == null
                      ? Text("no image url")
                      : Image.file(
                          File(path!),
                          fit: BoxFit.cover,
                          width: widget.size!.width,
                        ),
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(),
                  ),
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "change ${widget.msg}".capitalize!,
                      textScaleFactor: 1,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ))),
          ],
        ),
        decoration: BoxDecoration(
          // color: Colors.blueGrey.shade300,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 7,
            color: Colors.black.withOpacity(.3),
          ),
        ),
      ),
    );
  }
}
