import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.login.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final controller = Get.put(LoginState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            // padding: EdgeInsets.symmetric(horizontal: 30),
            child: Stack(
              children: [
                Positioned(
                    top: Get.height / 10,
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 200,
                      width: Get.width,
                      child: Text(
                        "ENTO",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 90),
                      ),
                    )),
                Positioned(
                  top: Get.height / 4,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      // color: Colors.redAccent,
                      width: Get.width - 30,
                      height: Get.height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            controller: controller.email,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(CupertinoIcons.at),
                              helperText: "",
                            ),
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            obscureText: true,
                            controller: controller.password,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(CupertinoIcons.lock_fill),
                              helperText: "",
                            ),
                          ),
                          controller.obx(
                            (state) => Container(
                              alignment: Alignment.centerRight,
                              child: SizedBox.fromSize(
                                size: Size(Get.width / 1.8, 60),
                                child: ListTile(
                                  dense: false,
                                  title: Text("i am a company"),
                                  trailing: Container(
                                    child: Switch(
                                      onChanged: (value) {
                                        controller.toggleIsCompany();
                                      },
                                      value: controller.isCompany,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.onLogin();
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.downhill_skiing),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("login"),
                                    ],
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.onRegister();
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.sledding_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("register"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
