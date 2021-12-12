import 'package:ento/frontend/customer/companies/view.companies.dart';
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("login"),
                  TextButton(
                      onPressed: () {
                        Get.off(() => CompaniesView());
                      },
                      child: Text("login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
