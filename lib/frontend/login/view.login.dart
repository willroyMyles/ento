import 'package:ento/frontend/customer/companies/view.companies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(CupertinoIcons.at),
                              helperText: "",
                            ),
                          ),
                          TextField(
                            textAlign: TextAlign.center,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(CupertinoIcons.lock_fill),
                              helperText: "",
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: SizedBox.fromSize(
                              size: Size(Get.width / 1.8, 60),
                              child: ListTile(
                                dense: false,
                                title: Text("i am a company"),
                                trailing: Container(
                                  child: Switch(
                                    onChanged: (value) {},
                                    value: false,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(() => CompaniesView());
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.paperplane),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("login"),
                                ],
                              ),
                            ),
                          )
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
