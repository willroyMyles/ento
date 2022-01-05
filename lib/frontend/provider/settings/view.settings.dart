import 'package:ento/frontend/components/selectImageWidget.dart';
import 'package:ento/frontend/provider/settings/state.settings.dart';
import 'package:ento/services/information.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderSettingsView extends StatelessWidget {
  ProviderSettingsView({Key? key}) : super(key: key);
  final controller = Get.put(ProviderSettingsState());
  @override
  Widget build(BuildContext context) {
    var model = Get.find<InformationService>().myCompany.value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(model.name),
            toolbarHeight: 50,
            expandedHeight: 450,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                // width: Get.width,
                // height: 450,
                child: Stack(
                  children: [
                    if (model.backdrop != null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: Image.network(model.backdrop!).image,
                              fit: BoxFit.cover),
                        ),
                      ),
                    Container(
                      // color: Colors.green,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: ListTile(
                              onTap: () {},
                              tileColor: Colors.blueGrey,
                              title: Text(model.name),
                              subtitle: Text("change name"),
                              trailing: Icon(Icons.edit),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: ListTile(
                              onTap: () {},
                              tileColor: Colors.blueGrey,
                              title: Text(model.website ?? ""),
                              subtitle: Text("change website"),
                              trailing: Icon(Icons.edit),
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SelectImageWidget(
                                  msg: "backdrop",
                                  imageUrl: model.backdrop,
                                  valueSetter: controller.setBackdrop,
                                ),
                                SelectImageWidget(
                                  msg: "logo",
                                  imageUrl: model.logo,
                                  valueSetter: controller.setLogo,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // bottom: PreferredSize(
            //   preferredSize: Size(Get.width, 200),
            //   child: Expanded(
            //     child: Container(
            //       padding: EdgeInsets.all(15),
            //       width: Get.width,
            //       child: Column(
            //         mainAxisSize: MainAxisSize.max,
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(model.email),
            //           Text(model.website ?? ""),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
