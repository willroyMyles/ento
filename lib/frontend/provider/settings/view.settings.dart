import 'package:cached_network_image/cached_network_image.dart';
import 'package:ento/frontend/components/selectImageWidget.dart';
import 'package:ento/frontend/components/selectListImageWidget.dart';
import 'package:ento/frontend/provider/settings/state.settings.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderSettingsView extends StatelessWidget {
  ProviderSettingsView({Key? key}) : super(key: key);
  final controller = Get.put(ProviderSettingsState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProviderSettingsState>(builder: (state) {
        var model = Get.find<InformationService>().myCompany.value;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Text(model.name),
                    Text("settings"),
                  ],
                ),
              ),
              toolbarHeight: 50,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  // width: Get.width,
                  // height: 450,
                  child: Stack(
                    children: [
                      // if (model.backdrop != null)
                      Container(
                        // height: 250,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: Image.network(model.backdrop!).image,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            height: 70,
                            width: 70,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(1),
                                      blurRadius: 10,
                                      spreadRadius: 5)
                                ],
                                color: Colors.green.withOpacity(.9),
                                borderRadius: BorderRadius.circular(100)),
                            child: CachedNetworkImage(
                              imageUrl: model.logo ?? "",
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => Container(),
                              fit: BoxFit.cover,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  onTap: () {},
                  // tileColor: Colors.blueGrey,
                  title: Text(model.name),
                  subtitle: Text("change name"),
                  trailing: Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  onTap: () {},
                  // tileColor: Colors.blueGrey,
                  title: Text(model.website ?? ""),
                  subtitle: Text("change website"),
                  trailing: Icon(Icons.edit),
                ),
              ),
              SelectListImageWidget(
                msg: "backdrop",
                valueSetter: controller.setBackdrop,
                imageUrl: model.backdrop,
              ),
              SelectListImageWidget(
                msg: "logo",
                valueSetter: controller.setLogo,
                imageUrl: model.logo,
              ),
              // Container(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SelectImageWidget(
              //         msg: "backdrop",
              //         imageUrl: model.backdrop,
              //         valueSetter: controller.setBackdrop,
              //       ),
              //       SelectImageWidget(
              //         msg: "logo",
              //         imageUrl: model.logo,
              //         valueSetter: controller.setLogo,
              //       ),
              //     ],
              //   ),
              // )
            ]))
          ],
        );
      }),
    );
  }
}
