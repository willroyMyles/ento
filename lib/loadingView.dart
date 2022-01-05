import 'package:ento/frontend/customer/homepage/view.home.dart';
import 'package:ento/frontend/login/view.login.dart';
import 'package:ento/frontend/provider/notifications/view.pastNotification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'backend/api/api.dart';
import 'services/information.service.dart';
import 'services/storage.service.dart';

class LoadingView extends StatelessWidget {
  LoadingView({Key? key}) : super(key: key);
  final controller = Get.put(LoadingState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<LoadingState>(builder: (con) {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Container(
          padding: EdgeInsets.all(25),
          child: controller.loadingview(),
        ),
      );
    }));
  }
}

class LoadingState extends GetxController {
  double loading = 0;
  get loadingview => () => Container(
        key: ValueKey("load"),
        // color: Colors.red,
        alignment: Alignment.center,
        child: LinearProgressIndicator(
          value: loading,
          valueColor: AlwaysStoppedAnimation(Colors.black),
          backgroundColor: Colors.grey,
          color: Colors.red,
        ),
      );

  late Widget widget;
  late Widget nextView;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initalize();
    widget = loadingview();
  }

  void updateLoading(double val) {
    loading = val;
    refresh();
  }

  void initalize() async {
    await Firebase.initializeApp();
    updateLoading(.2);
    await storeage.init();
    updateLoading(.4);
    Get.put(ApiCall());
    updateLoading(.6);
    var info = Get.find<InformationService>();
    updateLoading(.8);

    info.isSignedIn.stream.listen((event) {
      print("this is event $event");
      updateLoading(1);
      if (event) {
        Future.delayed(Duration(milliseconds: 350), () {
          if (info.userData.value.company != null) {
            Get.off(() => PastNotifications());
          } else {
            Get.off(() => HomeView());
          }
        });
      } else {
        Get.off(() => LoginView());
      }
    });
  }
}
