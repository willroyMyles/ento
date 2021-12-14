import 'package:flutter/material.dart';

class ThemeService {
  late ThemeData darkTheme;
  late ThemeData lightTheme;

  ThemeService() {
    darkTheme =
        ThemeData(brightness: Brightness.dark, canvasColor: Colors.transparent);

    lightTheme = ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.blueGrey.shade50);
  }
}

ThemeService ts = ThemeService();
ThemeService get themeService => ts;
