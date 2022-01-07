import 'package:cached_network_image/cached_network_image.dart';
import 'package:ento/frontend/provider/settings/state.settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';

class SelectListImageWidget extends StatelessWidget {
  final String msg;
  final String? imageUrl;
  final ValueSetter<String> valueSetter;
  SelectListImageWidget(
      {Key? key, required this.msg, this.imageUrl, required this.valueSetter})
      : super(key: key);

  final controller = Get.find<ProviderSettingsState>();

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
        valueSetter(media.path);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          selectImage();
        },
        child: ListTile(
          title: Text("$msg".capitalize!),
          subtitle: Text("change $msg"),
          trailing: Container(
            width: Get.width * .4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  child: GetBuilder<ProviderSettingsState>(builder: (state) {
                    return CachedNetworkImage(
                      imageUrl: imageUrl ?? "",
                      errorWidget: (context, url, error) => Container(),
                      placeholder: (context, url) => Container(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
                if (imageUrl == null)
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Icon(Icons.image))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
