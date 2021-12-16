import 'package:ento/backend/api/api.dart';
import 'package:ento/frontend/login/view.login.dart';
import 'package:ento/services/tags.service.dart';
import 'package:ento/services/theme.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut(() => ApiCall());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeService.lightTheme,
      routes: {"/": (context) => MainPage()},
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}
