import 'package:ento/backend/api/api.dart';
import 'package:ento/frontend/customer/homepage/view.home.dart';
import 'package:ento/frontend/login/view.login.dart';
import 'package:ento/services/information.service.dart';
import 'package:ento/services/storage.service.dart';
import 'package:ento/services/theme.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = true;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    initalize();
  }

  @override
  Widget build(BuildContext context) {
    if (loading)
      return MaterialApp(
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Text("loading"),
          ),
        ),
      );
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeService.lightTheme,
      routes: {"/": (context) => LoginView()},
    );
  }

  void initalize() async {
    await Firebase.initializeApp();
    await storeage.init();
    Get.put(ApiCall());
    var info = Get.find<InformationService>();
    info.isSignedIn.stream.listen((event) {
      print("this is event $event");
      setState(() {
        loading = false;
      });
    });
  }
}

class MainPage extends StatelessWidget {
  final bool isLoggedIn;
  const MainPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn)
      return HomeView();
    else
      return LoginView();
  }
}
