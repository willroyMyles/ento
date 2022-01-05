import 'package:ento/frontend/components/items/company.item.dart';
import 'package:ento/frontend/customer/companies/state.companies.dart';
import 'package:ento/frontend/customer/qrcode/view.QrCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCompaniesView extends StatelessWidget {
  AllCompaniesView({Key? key}) : super(key: key);
  final controller = Get.find<CompanyState>();

  @override
  Widget build(BuildContext context) {
    var items = controller.info.companies.value.values.toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Companies"),
          ),
          SliverAppBar(
              primary: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Container(
                width: Get.width,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(102),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: TextButton.icon(
                          onPressed: () {
                            Get.to(() => ScanQRCode());
                          },
                          icon: Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                          ),
                          label: Container(),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 30,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        child: TextButton.icon(
                          onPressed: () {
                            Get.to(() => ScanQRCode());
                          },
                          icon: Icon(
                            CupertinoIcons.qrcode_viewfinder,
                            color: Colors.black,
                          ),
                          label: Container(),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          SliverList(
              delegate: SliverChildListDelegate(
                  items.map((e) => CompanyItem(model: e)).toList()))
        ],
      ),
    );
  }
}
