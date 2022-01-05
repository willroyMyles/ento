import 'package:ento/backend/models/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationCustomerDetail extends StatelessWidget {
  final NotificationModel model;
  final ScrollController? con;
  const NotificationCustomerDetail({Key? key, required this.model, this.con})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 15, color: Colors.black.withOpacity(.3))
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: CustomScrollView(
        controller: con,
        slivers: [
          SliverAppBar(
            leading: Container(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              model.name ?? "",
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade900,
            flexibleSpace: FlexibleSpaceBar(),
          ),
          SliverToBoxAdapter(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      model.title * 1000,
                      softWrap: true,
                    )),
                Container(
                    padding: EdgeInsets.all(15), child: Text(model.body!)),
                if (model.picture != null)
                  Container(
                    height: 200,
                    width: Get.width,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 23),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black.withOpacity(.3))
                        ],
                        image: DecorationImage(
                            image: Image.network(model.picture!).image,
                            fit: BoxFit.fitWidth)),
                  ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
